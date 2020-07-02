import 'package:PicToShare/ui/dashboard.dart';
import 'package:PicToShare/ui/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonColor: Colors.orange[200],
        primarySwatch: Colors.deepOrange,
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) //check for connection state
          return CircularProgressIndicator();
        if (!snapshot.hasData ||
            snapshot.data == null) // checks if user is present or not
        {
          return LoginPage();
        } else {
          print('main screen ${snapshot.data.email}');
          return DashBoardPage(email: snapshot.data.email);
        }
      },
    );
  }
}
