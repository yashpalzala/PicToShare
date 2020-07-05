// implemented only google sign in through api . user does not have to remeber passwords
//* All the commented part contains regular email sign-in fully working.

import 'dart:ffi';

import 'package:PicToShare/ui/dashboard.dart';
import 'package:PicToShare/ui/registrationpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:PicToShare/servs/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  String res;
  /*  @override
  Widget build(BuildContext context) {
    print('login page $res');
    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset('assets/orangepixelated.jpg',
                  fit: BoxFit.fill,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                  colorBlendMode: BlendMode.modulate),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                Container(
                  width: 300.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Color(0xffffffff),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.google,
                              color: Color(0xffCE107C),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 25.0),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        res = await AuthProvider().loginWithGoogle();

                        print('checking res value: $res');
                        if (res == null) {
                          print("error logging in with google");
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                              content: Text(
                                'Oops! cannot sign you in . Use google accounts for better experience',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          );
                        } else {
                          print('login page $res');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashBoardPage(
                                email: res,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                Text('*Hassle-free Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.white,
                    )),
                Text('*No need to remember password',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.white))
              ],
            ),
          ],
        ),
      ),
    );
  }
} */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: ''),
            ),
          ),
          
        ]),
      ),
      body: Builder(
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset('assets/orangepixelated.jpg',
                  fit: BoxFit.fill,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                  colorBlendMode: BlendMode.modulate),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     TextField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: "Enter email"),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Enter password"),
                    ),
                    const SizedBox(height: 30.0),
                    Center(
                      child: RaisedButton(
                        color: Colors.deepOrangeAccent,
                        child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        onPressed: () async {
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            print("Email and password cannot be empty");
                            return null;
                          }
                          String res = await AuthProvider()
                              .signInWithEmailAndPassword(
                                  _emailController.text, _passwordController.text);
                          switch (res) {
                            case 'user not found.':
                            print('user not found.');
                              Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.deepOrangeAccent,
                                        content: Text(
                                          'Email address not found',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    );
                                    return 'user not found.';
                              
                              break;
                            case 'password not valid.':
                            print('password not valid.');
                            Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.deepOrangeAccent,
                                        content: Text(
                                          'password not valid',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    );
                              return 'password not valid.';
                              break;
                            case 'Network error.':
                            print('Network error.');
                            Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.deepOrangeAccent,
                                        content: Text(
                                          'Network error',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    );
                              return 'Network error.';
                              break;
                              case 'email not verified':
                            print('email not verified');
                            Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.deepOrangeAccent,
                                        content: Text(
                                          'Email is not verified',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    );
                              return 'email not verified';
                              break;
                            // ...
                            default:
                              
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashBoardPage(
                                  email: res,
                                ),
                              ),
                            );
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 50),
                    Center(
                      child:Text('New User? Click below to register.', style: TextStyle(color: Colors.deepOrange, fontSize: 20, fontWeight: FontWeight.bold),)
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: RaisedButton(
                        color: Colors.deepOrangeAccent,
                        child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
