import 'dart:convert';

import 'package:cowchat/constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/User.dart';
import '../../../services/FirestoreService.dart';
import '../../../services/authentication_service.dart';
import '../../../utils/CWWidgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var dobController = TextEditingController();
  var genderController = TextEditingController();
  var addressController = TextEditingController();
  var qualificationController = TextEditingController();
  var gender="Male";
  final FirestoreService _firestoreService=FirestoreService();
  final AuthenticationService _firebaseAuthService=AuthenticationService();
  @override
  void initState() {
    super.initState();

    getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Form(
        key:_formKey,
          child:
      Container(
          height: double.infinity,
          child: Stack(children: [
            Container(
                padding: const EdgeInsets.only(bottom: 65.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  color: redColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              height: 150,
                              width: double.infinity,
                            ),
                            Positioned(
                              bottom: 60.0,
                              right: 10.0,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: white,
                                      border: Border.all(color: CWPrimaryColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  height: 35,
                                  width: 35,
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                  )).onTap((){
                                Fluttertoast.showToast(msg: 'Change Background');
                              }),
                            ),
                            Positioned(
                              bottom: 16.0,
                              left: 2.0,
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: CWPrimaryColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  height: 96,
                                  width: 96,
                                  child: const CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: NetworkImage(
                                        'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
                                    backgroundColor: Colors.transparent,
                                  )),
                            ),
                            Positioned(
                              bottom: 20.0,
                              left: 60.0,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: white,
                                      border: Border.all(color: CWPrimaryColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  height: 35,
                                  width: 35,
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                  )).onTap((){
                                Fluttertoast.showToast(msg: 'Change profile');
                              }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Name',
                                  style: boldTextStyle(
                                      fontFamily: 'Poppins', size: 13),
                                ))
                              ],
                            ),
                            8.height,
                            TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: waInputDecoration(
                                prefixIcon: Icons.person,
                                hint: 'Name',
                              ),
                              style: secondaryTextStyle(
                                  size: 12, fontFamily: 'Poppins'),

                            ),
                            8.height,
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Phone',
                                  style: boldTextStyle(
                                      fontFamily: 'Poppins', size: 13),
                                ))
                              ],
                            ),
                            8.height,
                            TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: waInputDecoration(
                                prefixIcon: Icons.phone,
                                hint: 'Phone',
                              ),
                              style: secondaryTextStyle(
                                  size: 12, fontFamily: 'Poppins'),
                            ),
                            8.height,
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Email',
                                  style: boldTextStyle(
                                      fontFamily: 'Poppins', size: 13),
                                ))
                              ],
                            ),
                            8.height,
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: waInputDecoration(
                                prefixIcon: Icons.email_outlined,
                                hint: 'Email',
                              ),
                              style: secondaryTextStyle(
                                  size: 12, fontFamily: 'Poppins'),
                            ),
                            8.height,
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'D.O.B',
                                  style: boldTextStyle(
                                      fontFamily: 'Poppins', size: 13),
                                ))
                              ],
                            ),
                            8.height,
                            TextFormField(
                              controller: dobController,
                              keyboardType: TextInputType.datetime,
                              decoration: waInputDecoration(
                                prefixIcon: Icons.date_range,
                                hint: 'D.O.B',
                              ),
                              style: secondaryTextStyle(
                                  size: 12, fontFamily: 'Poppins'),
                            ),
                            8.height,
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Gender',
                                  style: boldTextStyle(
                                      fontFamily: 'Poppins', size: 13),
                                ))
                              ],
                            ),
                            8.height,
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration:
                                        boxDecorationRoundedWithShadow(
                                          8,
                                          backgroundColor:gender=="Male"?CWPrimaryColor:
                                          context
                                              .cardColor,
                                          shadowColor: Colors
                                              .grey
                                              .withOpacity(
                                              0.2),
                                        ),
                                    child: Column(
                                      children: [
                                         Icon(Icons.male,color:gender=="Male"?white:CWPrimaryColor,),
                                        5.height,
                                        Text("Male",style: boldTextStyle(
                                            size: 12, fontFamily: 'Poppins',color: gender=="Male"?white:gray),)
                                      ],
                                    ),
                                  ).onTap((){
                                    setState(() {
                                      gender="Male";
                                    });
                                      })),
                                  const SizedBox(width: 8.0,),
                                  Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration:
                                        boxDecorationRoundedWithShadow(
                                          8,
                                          backgroundColor:gender=="Female"?CWPrimaryColor:
                                          context
                                              .cardColor,
                                          shadowColor: Colors
                                              .grey
                                              .withOpacity(
                                              0.2),
                                        ),
                                        child: Column(
                                          children: [
                                             Icon(Icons.female,color: gender=="Female"?white:CWPrimaryColor,),
                                            5.height,
                                            Text("Female",style: boldTextStyle(
                                                size: 12, fontFamily: 'Poppins',color: gender=="Female"?white:gray),)
                                          ],
                                        ),
                                      ).onTap((){
                                        setState(() {
                                          gender="Female";
                                        });
                                      })),
                                  const SizedBox(width: 8.0,),
                                  Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration:
                                        boxDecorationRoundedWithShadow(
                                          8,
                                          backgroundColor:gender=="Transgender"?CWPrimaryColor:context.cardColor,
                                          shadowColor: Colors
                                              .grey
                                              .withOpacity(
                                              0.2),
                                        ),
                                        child: Column(
                                          children: [
                                             Icon(Icons.transgender,color: gender=="Transgender"?white:CWPrimaryColor,),
                                            5.height,
                                            Text("Transgender",style: boldTextStyle(
                                                size: 12, fontFamily: 'Poppins',color: gender=="Transgender"?white:gray),)
                                          ],
                                        ),
                                      ).onTap((){
                                        setState(() {
                                          gender="Transgender";
                                        });
                                      })),
                                ],
                              ),
                            ),
                            8.height,
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Address',
                                  style: boldTextStyle(
                                      fontFamily: 'Poppins', size: 13),
                                ))
                              ],
                            ),
                            8.height,
                            TextFormField(
                              controller: addressController,
                              keyboardType: TextInputType.streetAddress,
                              minLines: 3,
                              maxLines: 5,
                              decoration: waInputDecoration(
                                prefixIcon: Icons.location_pin,
                                hint: 'Address',
                              ),
                              style: secondaryTextStyle(
                                  size: 12, fontFamily: 'Poppins'),
                            ),
                            8.height,
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Qualification',
                                  style: boldTextStyle(
                                      fontFamily: 'Poppins', size: 13),
                                ))
                              ],
                            ),
                            8.height,
                            TextFormField(
                              controller: qualificationController,
                              keyboardType: TextInputType.text,
                              minLines: 2,
                              maxLines: 3,
                              decoration: waInputDecoration(
                                prefixIcon: Icons.book,
                                hint: 'Qualification',
                              ),
                              style: secondaryTextStyle(
                                  size: 12, fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: boxDecorationRoundedWithShadow(
                  0,
                  backgroundColor: CWPrimaryColor,
                  shadowColor: Colors.grey.withOpacity(0.2),
                ),
                child: MaterialButton(
                  onPressed: ()  {
                    updateProfile();

                  },
                  child: Text(
                    'Save Profile',
                    style: boldTextStyle(
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            )
          ]))),
    );
  }

  void updateProfile() async {
    if(_formKey.currentState!.validate()){
      try {
        await _firestoreService.createUser(User(_firebaseAuthService.getId(), nameController.text.toString(), phoneController.text.toString(), emailController.text.toString(),dobController.text.toString(), gender,addressController.text.toString(), qualificationController.text.toString(), 'user'));
      } catch (e) {
        print(e);
      }
    }


  }

  Future<void> getCurrentUserData()  async {
    var  data=  await _firestoreService.getUser(_firebaseAuthService.getId().toString());
   setState(() {
     nameController.text=data['fullName'].toString();
     phoneController.text=data['phone'].toString();
     emailController.text=data['email'].toString();
     dobController.text=data['dob'].toString();
     genderController.text=data['gender'].toString();
     gender=data['gender'].toString();
     addressController.text=data['address'].toString();
     qualificationController.text=data['qualification'].toString();
   });
  }
}
