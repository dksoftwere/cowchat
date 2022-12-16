import 'dart:async';
import 'package:cowchat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rxdart/rxdart.dart';

// TODO import Dialogflowchrc
import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pb.dart';


class Chat extends StatefulWidget {
  const Chat({super.key});


  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<Suggestions> _suggestions = <Suggestions>[];
  final TextEditingController _textController = TextEditingController();

  bool _isRecording = false;

  // RecorderStream _recorder = RecorderStream();
  StreamSubscription ?_recorderStatus;
  StreamSubscription<List<int>> ?_audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;
  // TODO import Dialogflow
  DialogflowGrpcV2Beta1 ? dialogflow;
  @override
  void initState() {
    super.initState();
    initPlugin();
  }

  @override
  void dispose() {
    _recorderStatus?.cancel();
    _audioStreamSubscription?.cancel();
    super.dispose();
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {

    // TODO Get a Service account
    // Get a Service account
    final serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString('assets/cowchat-a4bf5-e61a92d6b694.json'))}');
    // Create a DialogflowGrpc Instance
    dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);
    try{
      DetectIntentResponse data = await dialogflow!.detectIntent("Welcome", 'en-in');
      String fulfillmentText = data.queryResult.fulfillmentText;
      //test
      var  chips = data.queryResult.fulfillmentMessages[1].suggestions;
      chips.suggestions.forEach((element) {
        Suggestions sug=Suggestions(title:element.title.toString());
        setState(() {
          _suggestions.insert(0, sug);
        });
      });
      //test
      print("response text ::$fulfillmentText");
      if(fulfillmentText.isNotEmpty) {
        ChatMessage botMessage = ChatMessage(
          text: fulfillmentText,
          name: "Cowchat",
          type: false,
          suggestions: _suggestions,
        );
        print(botMessage);
        setState(() {
          _messages.insert(0, botMessage);
        });
      }
    }catch(e){
      print("Here is error :: $e");
    }


    //initialized aoudio striming
    // _recorderStatus = _recorder.status.listen((status) {
    //   if (mounted)
    //     setState(() {
    //       _isRecording = status == SoundStreamStatus.Playing;
    //     });
    // });

    // await Future.wait([
    //   _recorder.initialize()
    // ]);

  }


  void stopStream() async {
    // await _recorder.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
  }


  void handleSubmitted(text) async {
    print(text);
    _textController.clear();
    _suggestions.clear();
    //TODO Dialogflow Code
    ChatMessage message = ChatMessage(
      text: text,
      name: "You",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    try{
      DetectIntentResponse data = await dialogflow!.detectIntent(text, 'en-in');
      String fulfillmentText = data.queryResult.fulfillmentText;
      //test
      // var  chips = data.queryResult.fulfillmentMessages[1].suggestions;
      // chips.suggestions.forEach((element) {
      //   Suggestions sug=Suggestions(title:element.title.toString());
      //   setState(() {
      //     _suggestions.insert(0, sug);
      //   });
      // });
      //test
      print("response text ::$fulfillmentText");
      if(fulfillmentText.isNotEmpty) {
        ChatMessage botMessage = ChatMessage(
          text: fulfillmentText,
          name: "Cowchat",
          type: false,
          suggestions: _suggestions,
        );
        print(botMessage);
        setState(() {
          _messages.insert(0, botMessage);
        });
      }
    }catch(e){
      print("Here is error :: $e");
    }

  }

  void handleStream() async {
    // _recorder.start();
    _audioStream = BehaviorSubject<List<int>>();
    // _audioStreamSubscription = _recorder.audioStream.listen((data) {
    //   print(data);
    //   _audioStream!.add(data);
    // });

    // TODO Create SpeechContexts
    // Create an audio InputConfig
    var biasList = SpeechContextV2Beta1(
        phrases: [
          'Dialogflow CX',
          'Dialogflow Essentials',
          'Action Builder',
          'HIPAA'
        ],
        boost: 20.0
    );

    // See: https://cloud.google.com/dialogflow/es/docs/reference/rpc/google.cloud.dialogflow.v2#google.cloud.dialogflow.v2.InputAudioConfig
    var config = InputConfigV2beta1(
        encoding: 'AUDIO_ENCODING_LINEAR_16',
        languageCode: 'en-US',
        sampleRateHertz: 16000,
        singleUtterance: false,
        speechContexts: [biasList]
    );

    // TODO Make the streamingDetectIntent call, with the InputConfig and the audioStream
    // TODO Get the transcript and detectedIntent and show on screen

    final responseStream = dialogflow!.streamingDetectIntent(config, _audioStream!);
    // Get the transcript and detectedIntent and show on screen
    responseStream.listen((data) {
      print('First :: ----');
      setState(() {
        print("print recorded data $data");
        String transcript = data.recognitionResult.transcript;
        String queryText = data.queryResult.queryText;
        String fulfillmentText = data.queryResult.fulfillmentText;
        if(fulfillmentText.isNotEmpty) {
          ChatMessage message = ChatMessage(
            text: queryText,
            name: "You",
            type: true,
          );
          ChatMessage botMessage = ChatMessage(
            text: fulfillmentText,
            name: "Cowchat",
            type: false,
            suggestions: _suggestions,
          );
          _messages.insert(0, message);
          _textController.clear();
          _messages.insert(0, botMessage);

        }
        if(transcript.isNotEmpty) {
          _textController.text = transcript;
        }
      });
    },onError: (e){
      print("Error on audio record :: $e");
    },onDone: () {
      print('done');

    });

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: context.height(),
            width: context.width(),
            child: Stack(
              children: [
                Container(
                  child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 100.0,top: 0.0),
                            reverse: true,
                            shrinkWrap: true,
                            itemBuilder: (_, int index) => _messages[index],
                            itemCount: _messages.length,
                          ),

                      ])),
                ),

                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  left: 0.0,
                  child: Container(
                      decoration: BoxDecoration(color: Theme.of(context).cardColor),
                      child: IconTheme(
                        data: IconThemeData(color: Theme.of(context).accentColor),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _textController,
                                  onSubmitted: handleSubmitted,
                                  decoration: const InputDecoration.collapsed(
                                      hintText: "Send a message"),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () =>
                                      handleSubmitted(_textController.text),
                                ),
                              ),
                              IconButton(
                                iconSize: 30.0,
                                icon:
                                Icon(_isRecording ? Icons.mic_off : Icons.mic),
                                onPressed: _isRecording ? stopStream : handleStream,
                              ),
                            ],
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}

//------------------------------------------------------------------------------------
// The chat message balloon
//
//------------------------------------------------------------------------------------
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type,this.suggestions});

  String ?text;
  String? name;
  bool ?type;
  List<Suggestions> ?suggestions;



  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(backgroundColor: CWPrimaryColor,child:  Text('B',style: boldTextStyle(fontFamily: 'Poppins',color: white),),),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name!, style: boldTextStyle(color: CWPrimaryColor,size: 14)),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(text!,style: secondaryTextStyle(fontFamily: 'Poppins',size: 13),),
            ),
            16.height,
            Container(
              height: 48.0,
              child: ListView.builder(
                padding: const EdgeInsets.all(0.0),
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (_, int index) => this.suggestions![index],
                itemCount: this.suggestions!.length,
              ),
            )
          ],
        ),
      ),
    ];
  }
  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(this.name!, style:boldTextStyle(size: 14,color: blueColor,fontFamily: 'Poppins')),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(text!,style: secondaryTextStyle(fontFamily: 'Poppins',size: 13),),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
            child: Text(
              this.name![0],
              style: boldTextStyle(color: white,fontFamily: 'Poppins'),
            )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type! ? myMessage(context):otherMessage(context),
      ),
    );
  }
}


//suggetions

class Suggestions extends StatelessWidget {
  Suggestions({this.title});
  String ?title;

  Widget mySuggetions(context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(16.0)),border: Border.all(color: CWPrimaryColor.withOpacity(0.1),width: 1)),
      child: Text(title!,textAlign:TextAlign.center,style: secondaryTextStyle(fontFamily: 'Poppins',size: 13,color: CWPrimaryColor),),
    ).onTap((){
      print(title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: mySuggetions(context));
  }


}
