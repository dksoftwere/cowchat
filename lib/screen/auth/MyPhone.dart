import 'package:cowchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/ProgressHUD.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);
  static String  verification="";
  static String  phoneNumber="";
  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserCredential? user;
  bool visible=false;
  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        inAsyncCall: visible,
        opacity: 0.3,
        child: WillPopScope(
        onWillPop: () async {
     Navigator.pushNamedAndRemoveUntil(context, '/signup', (route) => false);
      return true;
    },
    child: SafeArea(
     child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: white,
        leading: const BackButton(color: Colors.black,),
        title: Text('Send the code ',style: boldTextStyle(size: 16),),
        elevation: 3,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.send_to_mobile_rounded,color: CWPrimaryColor,
                size: 50,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: boldTextStyle(size: 22,color: CWPrimaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: secondaryTextStyle(
                  size: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                     Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration:const  InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:  CWPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: ()async {
                      setState(() {
                        visible=true;
                      });
                      try{
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber:'${countryController.text.toString().trim()}${_phoneController.text.toString().trim()}',
                        timeout: const Duration(seconds: 60),
                        verificationCompleted: (PhoneAuthCredential credential) async {
                          // await firebaseAuth.signInWithCredential(credential);
                          setState(() {
                            visible=false;
                          });
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          if (e.code == 'invalid-phone-number') {
                            Fluttertoast.showToast(msg: 'The provided phone number is not valid.');
                          }
                          Fluttertoast.showToast(msg: '$e');
                          setState(() {
                            visible=false;
                          });
                        },
                        codeSent: (String verificationId, int? resendToken) async {
                          MyPhone.verification=verificationId;
                          MyPhone.phoneNumber='${countryController.text.toString().trim()}${_phoneController.text.toString().trim()}';
                          Navigator.pushNamed(context, '/verify');
                          setState(() {
                            visible=false;
                          });
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          print(verificationId);
                          Fluttertoast.showToast(msg: 'Timed out waiting for SMS.');
                          setState(() {
                            visible=false;
                          });
                        },
                      );
                      }catch(e){
                        setState(() {
                          visible=false;
                        });
                        Fluttertoast.showToast(msg: errorSomethingWentWrong);
                      }
                    },
                    child: Text("Send the code",style: boldTextStyle(size: 16,color: white),)),
              )
            ],
          ),
        ),
      ),
    ))));
  }
}