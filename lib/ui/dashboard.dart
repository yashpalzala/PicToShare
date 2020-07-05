// this is main dahboard where user is redirected after signing in

import 'package:PicToShare/servs/photostream.dart';
import 'package:PicToShare/ui/bottomnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:PicToShare/misc/colors.dart';
import 'package:PicToShare/ui/appbackground.dart';
import 'package:PicToShare/ui/phonelog.dart';
import 'package:PicToShare/ui/profile.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardPage extends StatefulWidget {
  final bool phoneVer;
  final email;

  DashBoardPage({this.phoneVer, this.email});

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  File _image;
  var imageSource;
  bool isPhoneVer;
  String savedmail;
  TextEditingController dialogbox;
  String hashTagsValue;
  bool hashTagLoad = true;

//<-----------------Loads Data from Local storage------------------>

  loadData<String>() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        savedmail = prefs.getString('email');
      },
    );
  }

  //<------------this is used to assign variables values from firestore------------->

  

  @override
  void initState() {
    loadData();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    exists() {
   Firestore.instance
        .collection('user')
        .document(widget.email)
        .get()
        .then((DocumentSnapshot ds) {
      
        isPhoneVer = ds.data['isPhoneVer'];
        print('is phone no. verified : $isPhoneVer');
      
    });
  }
  exists();
    
    
//====== debug purpose=======
    print('savedmail: $savedmail');
    print('$savedmail');

// =========================//

//<----------------hashTags is used to create a dialog box for hashtag inputs------------->
    hashTags(downloadUrl, savedmail) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Please Enter HashTags'),
              ),
              content: Container(
                child: TextField(
                  controller: dialogbox,
                  onChanged: (newValue) {
                    hashTagsValue = newValue;
                    print(hashTagsValue);
                  },
                  onSubmitted: (newValue) {
                    setState(() {
                      hashTagsValue = newValue;
                      print(hashTagsValue);
                    });
                  },
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                    onPressed: () {
                      print(hashTags);
                      Firestore.instance
                          .collection('shared')
                          .document()
                          .setData({
                        'url': downloadUrl,
                        'user': savedmail,
                        'hashtags': hashTagsValue,
                        'date':  (DateTime.now())
                      });
                      Navigator.pop(context);
                    },
                    child: Text('submit'))
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              contentPadding: EdgeInsets.all(25)),
          barrierDismissible: true);
    }

    //=========================//
    // <-------------uploadPic upload pic to firebase storage------------------>

    Future uploadPic() async {
      String fileName = basename(_image.path);
      print('file Name $fileName');
      print('trial path $_image');
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);

      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      print('down url : $downloadUrl');
      hashTags(downloadUrl, savedmail);
      print("Profile Picture uploaded");
    }

    //======================//
    //<----------getImage helps in selecting image from gallery----------->

    Future getImage() async {
      imageSource = await ImagePicker().getImage(source: ImageSource.gallery);

      setState(
        () {
          _image = File(imageSource.path);
          print('Image Path $_image');
        },
      );

      uploadPic();
    }

  

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Pic To Share',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lobster'),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(
                            email: savedmail,
                          )));
            },
            icon: new IconTheme(
              data: new IconThemeData(size: 35, color: Colors.white),
              child: new Icon(Icons.person),
            ),
          ),
        ]),
      ),
      body: Stack(
        children: <Widget>[
          AppBackground(
            firstCircle: firstCircleColor,
            secondCircle: secondCircleColor,
            thirdCircle: thirdCircleColor,
          ),
          SafeArea(
            child: Column(children: [Expanded(child: PhotoStream())]),
          )
        ],
      ),
      bottomNavigationBar: BottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('is phone verified: $isPhoneVer');

          isPhoneVer ?? true

              // if phone no. is verified iage selection is enabled
              ? getImage()

              // will show a dialog box to verify phone no. if not verified
              : showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('Need to verify Phone no.'),
                      ),
                      content: Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PhoneLoginScreen(email: widget.email)));
                          },
                          child: Text('Verify Now',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.orange,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      contentPadding: EdgeInsets.all(25)),
                  barrierDismissible: true);
        },
        child: Icon(Icons.add_a_photo),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
