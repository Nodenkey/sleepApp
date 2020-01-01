import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/mainScreen': (context) => MainScreen(),
      },
      home: OnBoarding(),
    );
  }
}

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title: Text(
          'Dayie',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
      ),
      backgroundColor: Colors.redAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Image.asset(
              'assets/images/sleep.png',
              width: 400,
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Text(
            'Your sleep companion',
            style: GoogleFonts.alata(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/mainScreen');
            },
            color: Colors.red,
            elevation: 5,
            height: 40,
            child: Text(
              'Get Started',
              style: GoogleFonts.alata(
                  textStyle: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          )
        ],
      ),
    );
  }
}
