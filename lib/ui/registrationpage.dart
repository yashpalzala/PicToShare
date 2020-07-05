import 'package:PicToShare/servs/auth.dart';
import 'package:PicToShare/ui/loginpage.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

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
              'Registration',
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
                    
                    Text(
                      "Please register with your Email and password below :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.deepOrange),
                    ),
                    const SizedBox(height: 10.0),
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
                    const SizedBox(height: 20.0),
                    Text(
                      "A link will be sent to your email address please verify then you can login.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white),
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: RaisedButton(
                        color: Colors.deepOrangeAccent,
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            print("Email and password cannot be empty");
                            return;
                          }
                          String res = await AuthProvider()
                              .signUpWithEmailAndPassword(_emailController.text,
                                  _passwordController.text);
                          if (res == null) {
                            print("Login failed");
                          } else {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.deepOrangeAccent,
                                content: Text(
                                  'Verification link has been sent . Please verify and login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          }
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
