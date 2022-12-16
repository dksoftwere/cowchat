import 'package:cowchat/providers/Auth.dart';
import 'package:cowchat/screen/dashborad/HomeScreen.dart';
import 'package:cowchat/screen/dashborad/PricingScreen.dart';
import 'package:cowchat/screen/dashborad/AllJobsScreen.dart';
import 'package:cowchat/screen/dashborad/ProfileScreen.dart';
import 'package:cowchat/screen/dashborad/RatingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
   int index;
   DashboardScreen(this.index);

  @override
  DashboardScreenState createState() => DashboardScreenState(this.index);
}

class DashboardScreenState extends State<DashboardScreen> {
  int pageIndex = 0;

  final pages = [
    const HomeScreen(),
    const PricingScreen(),
    const AllJobsScreen(),
    const RatingsScreen(),
    const ProfileScreen(),

  ];
  DashboardScreenState(this.pageIndex);
  @override
  Widget build(BuildContext context) {
    return
      Consumer<User>(builder: (context, user, _) {
      return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          backgroundColor: const Color(0xffC4DFCB),
          body: pages[pageIndex],
          bottomNavigationBar:  buildMyNavBar(context),
        ),

      );
    });
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(20),
        //   topRight: Radius.circular(20),
        // ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.home_filled,
              color: Colors.indigo,
              size: 35,
            )
                : const Icon(
              Icons.home_outlined,
              color: Colors.indigo,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.work_rounded,
              color: Colors.indigo,
              size: 35,
            )
                : const Icon(
              Icons.work_outline_outlined,
              color: Colors.indigo,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.widgets_rounded,
              color: Colors.indigo,
              size: 35,
            )
                : const Icon(
              Icons.widgets_outlined,
              color: Colors.indigo,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
              Icons.star,
              color: Colors.indigo,
              size: 35,
            )
                : const Icon(
              Icons.star_border_outlined,
              color: Colors.indigo,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 4;
              });
            },
            icon: pageIndex == 4
                ? const Icon(
              Icons.person,
              color: Colors.indigo,
              size: 35,
            )
                : const Icon(
              Icons.person_outline,
              color: Colors.indigo,
              size: 35,
            ),
          ),

        ],
      ),
    );
  }

}
