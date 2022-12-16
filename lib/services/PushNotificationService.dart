import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: slash_for_doc_comments
/**
 * Documents added by Alaa, enjoy ^-^:
 * There are 3 major things to consider when dealing with push notification :
 * - Creating the notification
 * - Hanldle notification click
 * - App status (foreground/background and killed(Terminated))
 *
 * Creating the notification:
 *
 * - When the app is killed or in background state, creating the notification is handled through the back-end services.
 *   When the app is in the foreground, we have full control of the notification. so in this case we build the notification from scratch.
 *
 * Handle notification click:
 *
 * - When the app is killed, there is a function called getInitialMessage which
 *   returns the remoteMessage in case we receive a notification otherwise returns null.
 *   It can be called at any point of the application (Preferred to be after defining GetMaterialApp so that we can go to any screen without getting any errors)
 * - When the app is in the background, there is a function called onMessageOpenedApp which is called when user clicks on the notification.
 *   It returns the remoteMessage.
 * - When the app is in the foreground, there is a function flutterLocalNotificationsPlugin, is passes a future function called onSelectNotification which
 *   is called when user clicks on the notification.
 *
 * */
class PushNotificationService {
  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
   // await getToken();
// Get any messages which caused the application to open from a terminated state.
    // If you want to handle a notification click when the app is terminated, you can use `getInitialMessage`
    // to get the initial message, and depending in the remoteMessage, you can decide to handle the click
    // This function can be called from anywhere in your app, there is an example in main file.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null && initialMessage.data['action'] == 'chat') {
      print("app onBackground :: ${initialMessage.data['action']}");
    // Navigator.pushNamed(getContext, '/ChatScreen',
    //     arguments: ChatScreen('9','','dks','online'));
    }
// FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
// Also handle any interaction when the app is in the background via a
    // Stream listener
    // This function is called when the app is in the background and user clicks on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // sendBroadcast(BroadcastMessage(name: "au.com.trilogycare.carevicinity",data:message.data, ),);
      print('Remote data:${message.data.toString()}');
      var action = jsonDecode(message.data['other_data'].toString());
      print('action_type :: ${action['action_type'].toString()}');
      var resMessage = jsonDecode(message.data['message'].toString());
      if(action['action_type']=='chat'){
        print('Its Message to chat screen');
        // ChatScreen(resMessage['from_id'].toString(),resMessage['from_username'].toString(),).launch(getContext);
      }else{
        // DashboardScreen(0).launch(getContext);
      }
      print('Message ${resMessage['title']}');
      print('body ${resMessage['body'].toString()}');
      print("Opened");
    });
    await enableIOSNotifications();
    await registerNotificationListeners();

  }
  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSetttings,onSelectNotification: onSelectNotification);


// onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      // sendBroadcast(BroadcastMessage(name: "au.com.trilogycare.carevicinity",data:message!.data, ),);
      print('Remote data:${message!.data.toString()}');
      var action = jsonDecode(message.data['other_data'].toString());
      print('action_type :: ${action['action_type'].toString()}');
      if(action['action_type']=='chat'){
        print('Its Message to chat screen');

      }
      var resMessage = jsonDecode(message.data['message'].toString());
      print('Message ${resMessage['title']}');
      print('body ${resMessage['body'].toString()}');
      Payload payloadData = Payload(action_type : action['action_type'].toString(),from_id:resMessage['from_id'].toString(),from_username: resMessage['from_username'].toString());
      String noteJsonString = payloadData.toJsonString();
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
    // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
              playSound: true,
            ),
          ),
          payload:noteJsonString,
        );
      }
    });
  }
  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
  androidNotificationChannel() => AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', //title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  // getToken() async {
  //   String? firebaseTokan;
  //   firebaseTokan = await FirebaseMessaging.instance.getToken();
  //   print("Firebase tokan first : $firebaseTokan");
  //   setFirebaseToken(firebaseTokan!);
  // }
    Future _showNotificationWithDefaultSound(flip) async {
      // Show a notification after every 15 minute with the first
      // appearance happening a minute after invoking the method
      var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          importance: Importance.max,
          priority: Priority.high
      );
      var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
      // initialise channel platform for both Android and iOS device.
      var platformChannelSpecifics = new NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics
      );
    }
  void onSelectNotification(String? payload)async {
    Payload payloadData = Payload.fromJsonString(payload!);
    if(payloadData.action_type=='chat'){
      print('Its Message to chat screen');
      // ChatScreen(payloadData.from_id.toString(),payloadData.from_username.toString()).launch(getContext);
    }
    else{
      // DashboardScreen(0).launch(getContext);
    }
  }
}
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   androidNotificationChannel() => AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', //title
//     description:
//     'This channel is used for important notifications.', // description
//     importance: Importance.max,
//   );
//   AndroidNotificationChannel channel = androidNotificationChannel();
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//       AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
//   var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//   var iOSSettings = IOSInitializationSettings(
//     requestSoundPermission: false,
//     requestBadgePermission: false,
//     requestAlertPermission: false,
//   );
//   AppStore().messageComingIs=true;
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   // If `onMessage` is triggered with a notification, construct our own
//   // local notification to show to users using the created channel.
//   if (notification != null && android != null) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//          channel.name,
//           channelDescription:channel.description,
//           icon: android.smallIcon,
//           playSound: true,
//         ),
//       ),
//     );
//   }
//   print("Handling a background message");
//
// }


class Payload{
   final String action_type;
   final  String from_id;
  final  String from_username;

   Payload({required this.action_type,  required this.from_id,required this.from_username});

  //Add these methods below
  factory Payload.fromJsonString(String str) => Payload._fromJson(jsonDecode(str));

  String toJsonString() => jsonEncode(_toJson());

  factory Payload._fromJson(Map<String, dynamic> json) => Payload(
    action_type: json['action_type'],
    from_id: json['from_id'],
    from_username: json['from_username'],
  );
  Map<String, dynamic> _toJson() => {
    'action_type': action_type,
    'from_id': from_id,
    'from_username': from_username,
  };
}