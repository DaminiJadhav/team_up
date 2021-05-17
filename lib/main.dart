import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:teamup/screen/DashboardScreen.dart';
import 'package:teamup/screen/IntroScreen.dart';
import 'package:teamup/screen/LoginScreen.dart';
import 'package:teamup/screen/SelectLoginScreen.dart';
import 'package:teamup/utils/PushNotificationsManager.dart';
import 'dart:async';
import 'package:teamup/utils/SharedPreference.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeamUp',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Hexcolor('#0088ff'),
        accentColor: Hexcolor('#53a1e6'),
        accentColorBrightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          title: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),

          //headline1: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 20.0),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'TeamUp'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    PushNotificationsManager().init();
    Preference.init();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Preference.getBoolen()
                ? Preference.getIsLogin() ? Dashboard() : SelectLogin()
                : IntroScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/splashscreen/icon.png')),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
