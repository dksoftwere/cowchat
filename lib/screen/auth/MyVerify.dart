import 'package:cowchat/constants.dart';
import 'package:cowchat/screen/auth/MyPhone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';

import '../../services/SharedPreferenceHelper.dart';
import '../../utils/Countdown.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserCredential? user;
  AnimationController? _animationController;
  int levelClock = 1 * 60;
  final pinController = TextEditingController();


  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(seconds: levelClock), vsync: this);
    _animationController!.forward();
    super.initState();
    Future.delayed(Duration(seconds: levelClock), () {
      setState((){
        levelClock = 0;
      });

    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: white,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Verify Phone Number',
          style: boldTextStyle(size: 16),
        ),
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
                Icons.phone,
                size: 50,
                color: CWPrimaryColor,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: boldTextStyle(size: 22, color: CWPrimaryColor),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Otp send on: "),
                  Text(
                    MyPhone.phoneNumber,
                    style: boldTextStyle(color: CWPrimaryColor),
                  ),
                ],
              ),
              levelClock != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Resend code after: "),
                        Countdown(
                          animation: StepTween(
                            begin: levelClock, // THIS IS A USER ENTERED NUMBER
                            end: 0,
                          ).animate(_animationController!),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin:const  EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.only(top: 5.0,bottom: 5.0,left: 16.0,right: 16.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              border: Border.all(color: gray.withOpacity(0.5))),
                          child:  Text('Resend OTP',style: boldTextStyle(color: CWPrimaryColor,fontFamily: 'Poppins'),),
                        ).onTap((){


                        }),
                      ],
                    ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                controller: pinController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                onCompleted: (value) {
                  code = value;
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                androidSmsAutofillMethod:  AndroidSmsAutofillMethod.smsRetrieverApi,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: CWPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: MyPhone.verification,
                                smsCode: code);
                        // Sign the user in (or link) with the credential
                        await firebaseAuth.signInWithCredential(credential);
                        SharedPreferenceHelper()
                            .setName(credential.providerId.toString());
                        SharedPreferenceHelper()
                            .setEmail(credential.providerId.toString());
                        SharedPreferenceHelper()
                            .setImageUrl(credential.providerId.toString());
                        setState(() {});
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (route) => false);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      "Verify Phone Number",
                      style: boldTextStyle(size: 14, color: white),
                    )),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/phone');
                      },
                      child: Text(
                        "Edit Phone Number ?",
                        style: secondaryTextStyle(
                          color: Colors.black,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
