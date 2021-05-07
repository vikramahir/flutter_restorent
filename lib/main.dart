import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurants/resources/ApiProvider.dart';
import 'package:restaurants/ui/HomeScreen.dart';
import 'package:restaurants/utils/ConnectivityStatus.dart';
import 'package:restaurants/utils/SizeConfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ConnectivityStatus().init();
    ApiProvider().init();
    _goToHome();
  }

  _goToHome() {
    new Timer(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (SizeConfig.safeBlockHorizontal == null) SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Text(
          'Restaurants',
          textAlign: TextAlign.center,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
