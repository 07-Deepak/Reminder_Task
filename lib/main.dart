import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'splash_screen.dart'; // Ensure this is your splash screen

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBC7AOdKZCZV97Tlu2T7I5Fa4BnwGFoVOo',
      authDomain: 'yoga-e92db.firebaseapp.com',
      projectId: 'yoga-e92db',
      storageBucket: 'yoga-e92db.appspot.com',
      messagingSenderId: '322477041175',
      appId: '1:322477041175:android:1d8fed7299d70bee3f5e52',
      measurementId: 'G-MEASUREMENT_ID',
    ),
  );

  _initializeNotifications();
  runApp(MyApp());
}

void _initializeNotifications() {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  _createNotificationChannel();
}

void _createNotificationChannel() {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'reminder_channel_id', // id
    'Reminder Notifications', // title
    description: 'Channel for reminder notifications',
    importance: Importance.max,
    sound: RawResourceAndroidNotificationSound('reminder_sound'),
  );

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
