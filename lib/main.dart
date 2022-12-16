import 'package:cowchat/constants.dart';
import 'package:cowchat/providers/Auth.dart';
import 'package:cowchat/screen/DashboardScreen.dart';
import 'package:cowchat/screen/LoginScreen.dart';
import 'package:cowchat/screen/SignupScreen.dart';
import 'package:cowchat/screen/SplashScreen.dart';
import 'package:cowchat/screen/WalkScreen.dart';
import 'package:cowchat/screen/auth/MyEmail.dart';
import 'package:cowchat/screen/auth/MyPhone.dart';
import 'package:cowchat/screen/auth/MyVerify.dart';
import 'package:cowchat/screen/dashborad/screen/EditProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cowchat/AppTheme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'cowchat',
      options: const FirebaseOptions(
          apiKey: AppConstant.API_KEY,
          appId: AppConstant.APP_ID,
          messagingSenderId: AppConstant.MESSAGING_SENDER_ID,
          projectId: AppConstant.PROJECT_ID));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => User())],
      child: Consumer<User>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Coding of world',
          color: CWPrimaryColor,
          theme: AppThemeData.lightTheme,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          initialRoute: '/',
          routes: {
            '/home': (ctx) => DashboardScreen(0),
            '/login': (ctx) => const LoginScreen(),
            '/signup': (ctx) => const SignupScreen(),
            '/email': (ctx) => const MyEmail(),
            '/phone': (context) => const MyPhone(),
            '/verify': (context) => const MyVerify(),
            '/walk': (context) => const WalkScreen(),
            '/editProfile':(context)=>const EditProfileScreen()
          },
        ),
      ),
    );
  }
}

class MethodeChanelImplimentation extends StatefulWidget {
  @override
  MethodeChanelImplimentationState createState() =>
      MethodeChanelImplimentationState();
}

class MethodeChanelImplimentationState
    extends State<MethodeChanelImplimentation> {
  String? methodChanelValue;
  static const methodChannel = MethodChannel('userName');

  @override
  void initState() {
    super.initState();
    methodChanelValue = "Not initiated";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(methodChanelValue!),
    );
  }

  void initMethodChanel() async {
    String? returnValue =
        await methodChannel.invokeMethod<String>('getUserName');
    if (returnValue != null) {
      setState(() {
        methodChanelValue = returnValue;
      });
    }
  }
}
