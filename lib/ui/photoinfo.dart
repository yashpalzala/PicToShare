import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PhotoInfo extends StatefulWidget {
  final email;
  final url;
  final hashTags;
  final uploadTime;
  PhotoInfo({this.email, this.url, this.hashTags, this.uploadTime});
  @override
  _PhotoInfoState createState() => _PhotoInfoState();
}

class _PhotoInfoState extends State<PhotoInfo> {
  String userName;
  String userEmail;
  String uId;
  String hashTags;
  Timestamp uploadTime;

  fetchInfo() async {
    Firestore.instance.collection('user').document(widget.email).get().then(
      (DocumentSnapshot ds) {
        setState(
          () {
            userName = ds.data['username'];
            userEmail = widget.email;
            uId = ds.data['uid'];
            uploadTime = widget.uploadTime;
            print(userName);
            print(uId);
          },
        );
      },
    );
  }

  @override
  void initState() {
    fetchInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Photo Info',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lobster'),
              ),
            ),
          ],
        ),
      ),
      body: userName == null || uId == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Image.network(
                  widget.url,
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child:
                      //============================
                      Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Username : '),
                            Flexible(
                              child: new Text(
                                userName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Email : '),
                            Flexible(
                              child: new Text(
                                userEmail,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 17),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('hashtags : '),
                            Flexible(
                              child: new Text(
                                widget.hashTags,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 17),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('user Id : '),
                            Flexible(
                              child: new Text(
                                uId,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 17),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Date-Time : '),
                            Flexible(
                              child: new Text(
                                uploadTime.toDate().toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
