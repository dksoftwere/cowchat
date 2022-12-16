import 'package:cowchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../services/SharedPreferenceHelper.dart';
import '../DashboardScreen.dart';

class MyEmail extends StatefulWidget{
  const MyEmail({Key? key}) : super(key: key);

  @override
  State<MyEmail> createState()=>_MyEmailState();
}

class _MyEmailState extends State<MyEmail> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
        title: Text('Let\'s get started',style: boldTextStyle(color: Colors.black,size: 14),),
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
              Container(
                padding: EdgeInsets.only(left: 16,right: 16),
                child: Column(
                  children: [
                    10.height,
                    /*email*/ SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'you@gmail.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    /*password*/ SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'At least 6 characters',
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          suffixIcon: const Icon(
                            Icons.remove_red_eye,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                        ),
                      ),
                    ),
                    26.height,
                    Container(
                      width: 350,
                      decoration:
                      boxDecorationRoundedWithShadow(
                        8,
                        backgroundColor:CWPrimaryColor,
                        shadowColor: Colors
                            .grey
                            .withOpacity(
                            0.2),
                      ),
                      child: MaterialButton(
                        onPressed: ()async  {
                          var credential;
                          if(!emailController.text.validateEmail()){
                            Fluttertoast.showToast(msg: 'Enter valid email');
                            return;
                          }
                          try {
                              credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text.toString(),
                              password: passwordController.text.toString(),
                            );
                              SharedPreferenceHelper().setName(credential!.user!.displayName.toString());
                              SharedPreferenceHelper().setEmail(credential!.user!.email.toString());
                              SharedPreferenceHelper().setImageUrl(credential!.user!.photoURL.toString());
                              setState(() {

                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  DashboardScreen(0)),);


                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              Fluttertoast.showToast(msg: 'The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              Fluttertoast.showToast(msg: 'The account already exists for that email.');
                            }
                          } catch (e) {
                            Fluttertoast.showToast(msg: '$e');
                          }

                        },
                        child:  Text(
                          'Create Account',
                          style: boldTextStyle(
                            color: Colors.white,
                            size: 16,
                          ),
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
              ),
              8.height,
            ],
          ).center(),
        ),
      ),
    );
  }
}