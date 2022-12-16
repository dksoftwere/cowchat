import 'package:cowchat/constants.dart';
import 'package:cowchat/screen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/WalkThroughModel.dart';
import '../utils.dart';
import 'SignupScreen.dart';
class WalkScreen extends StatefulWidget{
  const WalkScreen({Key? key}) : super(key: key);

  @override
  State<WalkScreen> createState()=>_WalkScreenState();
}

class _WalkScreenState extends State<WalkScreen> {
  PageController pageController = PageController();
  List<WalkThroughModel> list = walkThroughList();
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color:Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              50.height,
              Row(children: [
                Container(child: Image.asset('assets/images/logo.png',height: 100,width: 100,fit: BoxFit.fill,),padding: EdgeInsets.all(10.0),),
              Text('Coding of world ',style: TextStyle(fontSize: 25,color: CWPrimaryColor,fontWeight: FontWeight.bold),)
              ],),
              Container(
                height: 400,
                width: 400,
                child: PageView(
                  controller: pageController,
                  children: list.map((e) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding:EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Image.asset(
                            e.image.validate(),
                            fit: BoxFit.fill,
                            height: 250,
                          ),
                        ),
                        8.height,
                        Text(e.title.validate(), style: boldTextStyle(size: 20, color: black,fontFamily: 'Poppins')).paddingOnly(left: 16, right: 16),
                        8.height,
                        Text(e.description.validate(), style: secondaryTextStyle(color: gray,fontFamily: 'Poppins'), textAlign: TextAlign.center).paddingOnly(left: 16, right: 16),
                      ],
                    );
                  }).toList(),
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                ),
              ),
              30.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < list.length; i++)
                    Container(child: Icon(Icons.circle, color: i == currentPage ? CWPrimaryColor : Colors.grey,size: 8,),margin: EdgeInsets.only(left: 16.0),),
                ],
              ),
              16.height,
              Column(
                children: [
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
                      onPressed: () {
                       SignupScreen().launch(context);
                      },
                      child: const Text(
                        ' Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
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
                      border: Border.all(color: CWPrimaryColor,width: 1)
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (currentPage == 2) {
                          const LoginScreen().launch(context);
                        } else {
                          pageController.animateToPage(currentPage + 1, duration: Duration(milliseconds: 300), curve: Curves.linear);
                        }
                      },
                      child:currentPage != 2?const Text('Next',style: TextStyle(
                        color:CWPrimaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ), ): const Text(
                        ' Log in',
                        style: TextStyle(
                          color:CWPrimaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              8.height,
            ],
          ),
        ),
      ),
    );
  }
}