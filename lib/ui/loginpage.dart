// implemented only google sign in through api . user does not have to remeber passwords
//* All the commented part contains regular email sign-in fully working.

import 'package:PicToShare/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:PicToShare/servs/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /* TextEditingController _emailController;
  TextEditingController _passwordController; */

/*   @override
  void initState() { 
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  } */
  String res;
  @override
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
}

/* @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 100.0),
              Text("Login", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),),
              const SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Login with Google"),
                onPressed: () async {
                  bool res = await AuthProvider().loginWithGoogle();
                  if(!res)
                    print("error logging in with google");
                },
              ),
              /* TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter email"
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter password"
                ),
              ),
              const SizedBox(height: 10.0),
              RaisedButton(
                child: Text("Login"),
                onPressed: ()async {
                  if(_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    print("Email and password cannot be empty");
                    return;
                  }
                  bool res = await AuthProvider().signInWithEmail(_emailController.text, _passwordController.text);
                  if(!res) {
                    print("Login failed");
                  }
                },
              ) */
            ],
          ),
        ),
      ),
    );
  }
} */
