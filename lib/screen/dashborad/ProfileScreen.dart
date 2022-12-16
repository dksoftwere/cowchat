import 'package:cowchat/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../services/FirestoreService.dart';
import '../../services/authentication_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>{
  final FirestoreService _firestoreService=FirestoreService();
  final AuthenticationService _firebaseAuthService=AuthenticationService();
  var name;
  var email;
  var phone;
  var role;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUserData();
    return Scaffold(
      backgroundColor: const Color(0xFFdde0e3),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.only(top: 48.0, left: 16.0, right: 16.0),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: CWPrimaryColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            height: 75,
                            width: 75,
                            child: const CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
                              backgroundColor: Colors.transparent,
                            )),
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          height: 75,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "${name!=null?name:'Ashourya rai bacchan'}",
                                    style: boldTextStyle(
                                        size: 20, fontFamily: 'Poppins'),
                                  ))
                                ],
                              ),
                              5.height,
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "${role!=null?role:'Software Engineer'}",
                                    style: secondaryTextStyle(
                                        size: 14, fontFamily: 'Poppins'),
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                    16.height,
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: CWPrimaryColor,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          '${phone!=null?phone:'8853389395'}',
                          style: secondaryTextStyle(
                              fontFamily: 'Poppins', size: 14),
                        )
                      ],
                    ),
                    8.height,
                    Row(
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          color: CWPrimaryColor,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          '${email!=null?email:'ashouryaraibacchan@gmail.com'}',
                          style: secondaryTextStyle(
                              fontFamily: 'Poppins', size: 14),
                        )
                      ],
                    ),
                    16.height,
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: const [
                                Text("\$425"),
                                Text("Total Earning"),
                              ],
                            )),
                            Expanded(
                                child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: gray.withOpacity(0.2)),
                                        shape: BoxShape.circle))),
                            Expanded(
                                child: Column(
                              children: const [Text('12'), Text('Order')],
                            )),
                          ],
                        )),
                    16.height,
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: gray.withOpacity(0.5)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: SettingItemWidget(
                            title: "Profile",
                            subTitle: "View and edit profile",
                            leading: const Icon(
                              Icons.person,
                              color: CWPrimaryColor,
                            ),
                            titleTextStyle: boldTextStyle(
                              fontFamily: 'Poppins',
                              size: 14,
                            ),
                            subTitleTextStyle: secondaryTextStyle(
                                fontFamily: 'Poppins', size: 12))).onTap((){
                                  Navigator.pushNamed(context,'/editProfile');
                    }),
                    8.height,
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: gray.withOpacity(0.5)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: SettingItemWidget(
                            title: "Profile",
                            subTitle: "View and edit profile",
                            leading: const Icon(
                              Icons.person,
                              color: CWPrimaryColor,
                            ),
                            titleTextStyle: boldTextStyle(
                              fontFamily: 'Poppins',
                              size: 14,
                            ),
                            subTitleTextStyle: secondaryTextStyle(
                                fontFamily: 'Poppins', size: 12))),
                    8.height,
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: gray.withOpacity(0.5)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: SettingItemWidget(
                            title: "Profile",
                            subTitle: "View and edit profile",
                            leading: const Icon(
                              Icons.person,
                              color: CWPrimaryColor,
                            ),
                            titleTextStyle: boldTextStyle(
                              fontFamily: 'Poppins',
                              size: 14,
                            ),
                            subTitleTextStyle: secondaryTextStyle(
                                fontFamily: 'Poppins', size: 12))),
                    8.height,
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: gray.withOpacity(0.5)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: SettingItemWidget(
                            title: "Profile",
                            subTitle: "View and edit profile",
                            leading: const Icon(
                              Icons.person,
                              color: CWPrimaryColor,
                            ),
                            titleTextStyle: boldTextStyle(
                              fontFamily: 'Poppins',
                              size: 14,
                            ),
                            subTitleTextStyle: secondaryTextStyle(
                                fontFamily: 'Poppins', size: 12))),
                    8.height,
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: gray.withOpacity(0.5)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: SettingItemWidget(
                            title: "Profile",
                            subTitle: "View and edit profile",
                            leading: const Icon(
                              Icons.person,
                              color: CWPrimaryColor,
                            ),
                            titleTextStyle: boldTextStyle(
                              fontFamily: 'Poppins',
                              size: 14,
                            ),
                            subTitleTextStyle: secondaryTextStyle(
                                fontFamily: 'Poppins', size: 12))),
                    8.height,
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: gray.withOpacity(0.5)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: SettingItemWidget(
                          title: "Log out",
                          subTitle: "Logout from app",
                          leading: const Icon(
                            Icons.logout,
                            color: errorColor,
                          ),
                          titleTextStyle: boldTextStyle(
                              fontFamily: 'Poppins',
                              size: 14,
                              color: errorColor),
                          subTitleTextStyle: secondaryTextStyle(
                              fontFamily: 'Poppins', size: 12),
                        )),
                    32.height,
                  ],
                )),
              )
            ],
          )),
    );
  }

  Future<void> getCurrentUserData()  async {
    var  data=  await _firestoreService.getUser(_firebaseAuthService.getId().toString());
    name=data['fullName'].toString();
    phone=data['phone'].toString();
    email=data['email'].toString();
    role=data['userRole'].toString();
    setState(() {
    });
  }
}
