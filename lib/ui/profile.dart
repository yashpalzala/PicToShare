import 'dart:ui';
import 'package:PicToShare/servs/auth.dart';
import 'package:PicToShare/ui/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final email;
  ProfilePage({this.email});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditingText = false;
  TextEditingController _editingControlleruserName;

  String userName;
  String userEmail;
  String uId;
  String url;

  initialValues() {
    Firestore.instance
        .collection('user')
        .document(widget.email)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        userName = ds.data['username'];
        userEmail = ds.data['email'];
        uId = ds.data['uid'];
        print(userName);
        print(uId);
      });
    });
  }

  Widget _userNameField() {
    if (_isEditingText)
      return Center(
        child: TextField(
          decoration: InputDecoration(hintText: userName),
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
          onSubmitted: (newValue) {
            setState(() {
              userName = newValue;
              Firestore.instance
                  .collection('user')
                  .document(widget.email)
                  .updateData({'username': userName});
              _isEditingText = false;
            });
          },
          autofocus: true,
          controller: _editingControlleruserName,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          userName,
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ));
  }

  loadData(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var savedUrl = prefs.getString(key);
    setState(() {
      url = savedUrl;
    });
    print('load data ka $url');
  }

  @override
  void initState() {
    print('Profile ka initstate');
    loadData('photourl');
    _editingControlleruserName = TextEditingController(text: userName);
    initialValues();
    super.initState();
  }

  @override
  void dispose() {
    _editingControlleruserName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Profile'),
      ),
      body: userName == null
          ? Center(child: CircularProgressIndicator())
          : Builder(
              builder: (context) => Container(
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.deepOrangeAccent,
                        child: ClipOval(
                          child: new SizedBox(
                            width: 130.0,
                            height: 130.0,
                            child: (url == null)
                                ? Image.asset(
                                    'assets/orangepixelated.jpg',
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    url,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child:
                          //============================
                          Column(
                        children: <Widget>[
                          Text('Username : '),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: _userNameField(),
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    setState(() {
                                      _isEditingText = true;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text('Email : '),
                          new GestureDetector(
                            onTap: () {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.white,
                                  content: Text(
                                    'Sorry you cannot edit that !!',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            },
                            child: new Text(
                              userEmail,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text('User Id : '),
                          Text(
                            uId,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.18,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    AuthProvider().logOut();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                  color: Colors.deepOrangeAccent,
                                  child: Text(
                                    'LogOut',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
