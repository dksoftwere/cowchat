import 'package:cowchat/component/video_preview.dart';
import 'package:cowchat/constants.dart';
import 'package:cowchat/screen/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../chatboat/MyChatboat.dart';
import '../../services/SharedPreferenceHelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<String> tagsList = [
    'Html',
    'Css',
    'JAVA',
    'Java script',
    'Bootstrap',
    'C',
    'C++',
    'Php',
    'Laravel'
  ];
  Map<String, double> dataMap = {
    "10-25": 45,
    "26-38": 5,
    "39-100": 50
  };
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
String name="";
String email="";
String imageUrl="";
  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }
  void getSharedPreference() async{
    name=await SharedPreferenceHelper().getName();
    email=await SharedPreferenceHelper().getEmail();
    imageUrl=await SharedPreferenceHelper().getImageUrl();
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
      return
        Scaffold(
          floatingActionButton:
          FloatingActionButton(
            backgroundColor: white,
            child: Container(
              height:80.0,
              width: 80.0,
              child: Stack(children: [
                Positioned(bottom: 5.0,left: 0.0,right: 0.0,child: Container(
                  height: 42,
                  width: 42,
                  decoration: const BoxDecoration(
                      color: CWPrimaryColor,
                      shape: BoxShape.circle
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height:5,
                        width:5,
                        decoration: const BoxDecoration(
                            color: white,
                            shape: BoxShape.circle
                        ),
                        child: const Text(''),),
                      const SizedBox(width: 5,),
                      Container(
                        height:5,
                        width:5,
                        decoration: const BoxDecoration(
                            color: white,
                            shape: BoxShape.circle
                        ),
                        child: const Text(''),),
                      const SizedBox(width: 5,),
                      Container(
                        height:5,
                        width:5,
                        decoration: const BoxDecoration(
                            color: white,
                            shape: BoxShape.circle
                        ),
                        child: const Text(''),),
                    ],),
                ),),
                Positioned(
                    top: 8.0,
                    left: 5.0,
                    right: 5.0,
                    child: Container(
                        padding: const EdgeInsets.all(2.0),
                        height: 16,
                        width: 16,
                        decoration: const BoxDecoration(
                            color: cRedColor,
                            shape: BoxShape.circle
                        ),
                        child:Text('1',textAlign: TextAlign.center,style: secondaryTextStyle(color: white,size: 8),))),
              ],),
            ),
            onPressed: () {
              MyChatboat().launch(context);
            },
          ),
        backgroundColor: const Color(0xFFdde0e3),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return Card(
                  elevation: 0.5,
                  child: Container(
                    child: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 24,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    ),
                  ));
            },
          ),
          backgroundColor: transparentColor,
          elevation: 0.0,
        ),
        drawer: Drawer(
          elevation: 0.0,
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              ListTile(
                leading:  CircleAvatar(backgroundImage: NetworkImage(imageUrl.toString()),),
                onTap: () {
                },
                title:  Text(name.toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle:  Text(email.toString()),
              ),
              ListTile(
                leading: const Icon(Icons.notifications),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const VideoPreview(url:'http://techslides.com/demos/sample-videos/small.mp4')));
                },
                title:  const Text('Notification',style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle:  const Text('Tab to go notification'),
              ),
              ListTile(
                leading: const Icon(Icons.login),
                onTap: () {
                  signOut();
                },
                title:  const Text('Logout',style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle:  const Text('Tab to Logout'),
              )
            ],
          ),
        ),
        body: Container(
            height: context.height(),
            width:context.width(),

            child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        width: context.width(),
                        height: 250,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.2),
                                  border: Border.all(color: Colors.grey.withOpacity(0.2),)),
                              height: 160,
                              width: context.width(),
                              child:  Image.asset('assets/images/girls.png'),
                            ),
                            Positioned(
                                top: 100,
                                left: 16,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white70, width: 3),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50))),
                                    height: 96,
                                    width: 96,
                                    child: const CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: NetworkImage(
                                          'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
                                      backgroundColor: Colors.transparent,
                                    ))),
                            Positioned(
                                top: 165,
                                left: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: const <Widget>[
                                        Text(
                                          "Marvin Steward",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const <Widget>[
                                        Text(
                                          "Software engineer",
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      children:  [
                                        Image.asset('assets/images/facebook.png',width: 20,height: 20,color: Colors.indigo,),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Image.asset('assets/images/twitter.png',width: 20,height: 20,),
                                        const  SizedBox(
                                          width: 5.0,
                                        ),
                                        Image.asset('assets/images/linkedin.png',width: 20,height: 20,),
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        Image.asset('assets/images/Instagram_icon.png',width: 20,height: 20,)
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        )),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text('TAGS',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(Icons.help)
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                        height: 40,
                        child: ListView.builder(
                            itemCount: tagsList.length,
                            shrinkWrap: true,
                            physics:const  AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.05),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.1),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 5.0,
                                    bottom: 5.0),
                                margin: const EdgeInsets.all(5.0),
                                child: Text(
                                  tagsList[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            })),
                    const SizedBox(
                      height: 8.0,
                    ),

                    Container(
                        height: 130,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(child: Wrap(children: [
                            Container(
                              width: context.width() / 1.7,
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.05),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 5.0,
                                  bottom: 16.0),
                              margin: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Card(
                                          elevation: 1.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset('assets/images/facebook.png',width: 25,height: 25,color: Colors.indigo,),
                                          )
                                      ),
                                      const Spacer(),
                                      Container(
                                        margin:
                                        const EdgeInsets.only(right: 10),
                                        child: const Text(
                                          '1K Views',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: const [
                                            Text(
                                              '4.2M',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Text(
                                              'Followers',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        child: Column(
                                          children: const [
                                            Text(
                                              '90',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Text(
                                              'Reactions',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        child: Column(
                                          children: const [
                                            Text(
                                              '345',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Text(
                                              'Connections',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: context.width()/ 1.7,
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.05),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 5.0,
                                  bottom: 16.0),
                              margin: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Card(
                                          elevation: 1.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset('assets/images/Instagram_icon.png',width: 25,height: 25,),
                                          )
                                      ),
                                      const Spacer(),
                                      Container(
                                        margin:
                                        const EdgeInsets.only(right: 10),
                                        child: const Text(
                                          '5K Views',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: const [
                                            Text(
                                              '8.5M',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Text(
                                              'Followers',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        child: Column(
                                          children: const [
                                            Text(
                                              '1000',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Text(
                                              'Reactions',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        child: Column(
                                          children: const [
                                            Text(
                                              '848',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Text(
                                              'Connections',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: context.width()/ 1.7,
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.05),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 5.0,
                                  bottom: 16.0),
                              margin: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Card(
                                          elevation: 1.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset('assets/images/twitter.png',width: 25,height: 25,),
                                          )
                                      ),
                                      const Spacer(),
                                      Container(
                                        margin:
                                        const EdgeInsets.only(right: 10),
                                        child: const Text(
                                          '2K Views',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: const [
                                            Text(
                                              '5.2M',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Text(
                                              'Followers',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        child: Column(
                                          children: const [
                                            Text(
                                              '140',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Text(
                                              'Reactions',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        child: Column(
                                          children: const [
                                            Text(
                                              '545',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Text(
                                              'Connections',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],),),)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 8.0,
                        ),
                        Text('Age Engagement Rate',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children:  [
                        const Spacer(),
                        Container(
                          width: context.width()/1.5,
                          height: 200,
                          child:
                          PieChart(
                            dataMap: dataMap,
                            animationDuration: const Duration(milliseconds: 800),
                            chartLegendSpacing: 32,
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32,
                            legendOptions: const LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.right,
                              showLegends: true,
                              legendShape: BoxShape.circle,
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                              decimalPlaces: 1,
                            ),
                            // gradientList: ---To add gradient colors---
                            // emptyColorGradient: ---Empty Color gradient---
                          ),),
                        const Spacer()
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 8.0,
                        ),
                        Text('Similar Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(children: const  [
                          ListTile(title:  Text("Angel Henry",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),subtitle:  Text("Actor",style: TextStyle(color: Colors.grey,fontSize: 14),),
                            leading:  CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
                              backgroundColor: Colors.transparent,
                            ),
                            trailing:  Icon(Icons.chevron_right,color: Colors.red, size: 35,),)

                        ],),
                      ),),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(children: const  [
                          ListTile(title:  Text("Colleen Lane",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),subtitle:  Text("Actor",style: TextStyle(color: Colors.grey,fontSize: 14),),
                            leading:  CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
                              backgroundColor: Colors.transparent,
                            ),
                            trailing:  Icon(Icons.chevron_right,color: Colors.red, size: 35,),)

                        ],),
                      ),),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 8.0,
                        ),
                        Text('Average Engagement Rate',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'google_sans')),
                      ],
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(children:   [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [  Card(elevation: 8.0,child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/facebook.png',width: 20,height: 20,),
                            ),),const SizedBox(width: 8.0,),const Text("5.54%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),const SizedBox(width: 8.0,),const Expanded(child: Text("Engegement",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),))],),),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [  Card(elevation: 8.0,child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/Instagram_icon.png',width: 20,height: 20,),
                            ),),const SizedBox(width: 8.0,),const Text("0.50%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),const SizedBox(width: 8.0,),const Expanded(child: Text("Engegement",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),))],),),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [  Card(elevation: 8.0,child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/twitter.png',width: 20,height: 20,),
                            ),),const SizedBox(width: 8.0,),const Text("1.20%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),const SizedBox(width: 8.0,),const Expanded(child: Text("Engegement",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),))],),)

                          ,
                          const SizedBox(
                            height: 16,
                          ),
                          Image.asset('assets/images/social_girls.png',width: context.width(),height: context.height()/3,)

                        ],),
                      ),),

                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ))),
      );
  }


  void signOut() async {
    await FirebaseAuth.instance.signOut().then((value) => {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  const LoginScreen()),)
      // setState(() {
      //   name = '';
      //   email = '';
      //   imageUrl = '';
      // })
    });
  }
}
