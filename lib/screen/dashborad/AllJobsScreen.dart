import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllJobsScreen extends StatelessWidget {
  const AllJobsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                      size: 35,
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
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          const Icon(
            Icons.notifications,
            color: Colors.black54,
            size: 30,
          ),
          const SizedBox(
            width: 8.0,
          ),
          const Icon(
            Icons.settings,
            color: Colors.black54,
            size: 30,
          ),
          Container(
              height: 48,
              width: 48,
              margin: const EdgeInsets.all(10),
              child: const CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
                backgroundColor: Colors.transparent,
              )),
          const SizedBox(
            width: 8.0,
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 0.0,
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Abhishek kumar vishwkarma'),
              accountEmail: Text('abhishek@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text('A'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              onTap: () {},
              title: const Text('Setting'),
              subtitle: const Text('Edit and save setting'),
            )
          ],
        ),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              border: Border.all(color: Colors.grey.withOpacity(0.2),)),
          margin: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Column(
                children: [

                ],
              ))),
    );
  }
}