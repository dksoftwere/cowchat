import 'package:cowchat/constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SignupScreen extends StatefulWidget{
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState()=>_SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: white,
        leading: BackButton(color: Colors.black,),
        title: Text('Let\'s get started',style: TextStyle(color: Colors.black),),
        elevation: 3,
      ),
      body: Container(
        color:Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              50.height,
              Container(child: Image.asset('assets/images/logo.png',height: 100,width: 100,fit: BoxFit.fill,),padding: EdgeInsets.all(10.0),),
              30.height,
              Column(
                children: [
                  10.height,
                  Container(
                    width: 350,
                    decoration:
                    BoxDecoration(
                        color: white,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: gray.withOpacity(0.5),width: 1)
                    ),
                    child: MaterialButton(
                      onPressed: () {

                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/google.png',height: 25,width: 25,),
                           SizedBox(width: 8.0,),
                           Text(
                            'Continue with Google',
                            style: TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.height,
                  Container(
                    width: 350,
                    decoration:
                    BoxDecoration(
                        color: white,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: gray.withOpacity(0.5),width: 1)
                    ),
                    child: MaterialButton(
                      onPressed: () {

                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/facebook.png',height: 25,width: 25,),
                           SizedBox(width: 8.0,),
                           Text(
                            'Continue with facebook',
                            style: TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.height,
                  Container(
                    width: 350,
                    decoration:
                    BoxDecoration(
                        color: white,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: gray.withOpacity(0.5),width: 1)
                    ),
                    child: MaterialButton(
                      onPressed: () {

                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/twitter.png',height: 25,width: 25,),
                           SizedBox(width: 8.0,),
                           Text(
                            'Continue with Twitter',
                            style: TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.height,
                  Container(
                    width: 350,
                    decoration:
                    BoxDecoration(
                        color: white,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: gray.withOpacity(0.5),width: 1)
                    ),
                    child: MaterialButton(
                      onPressed: () {

                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/github.png',height: 25,width: 25,),
                           SizedBox(width: 8.0,),
                           Text(
                            'Continue with Github',
                            style: TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.height,
                  Center(child: Text('OR'),),
                  10.height,
                  Container(
                    width: 350,
                    decoration:
                    BoxDecoration(
                        color: white,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: gray.withOpacity(0.5),width: 1)
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/email');
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email_outlined),
                           SizedBox(width: 8.0,),
                           Text(
                            'Continue with email',
                            style: TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.height,
                  Container(
                    width: 350,
                    decoration:
                    BoxDecoration(
                        color: white,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: gray.withOpacity(0.5),width: 1)
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/phone');
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone,),
                           SizedBox(width: 8.0,),
                           Text(
                            'Continue with Phone',
                            style: TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  26.height,
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: createRichText(list: [
                      TextSpan(text: "By creating an account , you agree to our ", style: secondaryTextStyle(size: 13)),
                      TextSpan(text: " User Agreement ", style: boldTextStyle(size: 14,color: CWPrimaryColor)),
                      TextSpan(text: " and that you have read ", style: secondaryTextStyle(size: 13)),
                      TextSpan(text: " Privacy Policy.", style: boldTextStyle(size: 14,color: CWPrimaryColor)),
                    ], textAlign: TextAlign.left),
                  ),

                ],
              ),
              8.height,
            ],
          ).center(),
        ),
      ),
    );
  }
}