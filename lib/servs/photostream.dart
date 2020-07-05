// this conatains STREAM BUILDER which is used to fetch all the photos and it's information

import 'package:PicToShare/ui/photoinfo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('shared').orderBy('date', descending: true).snapshots(), //query using orderby to keep the latest post u
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: new CircularProgressIndicator());
          default:
            return new ListView(
              children: snapshot.data.documents.map(
                (DocumentSnapshot document) {
                  return new ListTile(
                    subtitle: Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom:8.0),
                          child: Image.network(
                            document['url'],
                            height: MediaQuery.of(context).size.height * 0.5,
                            fit: BoxFit.contain,
                          ),
                        )),
                    title: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0, bottom: 2),
                        child: new Text(
                          document['user'],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.deepOrangeAccent,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      print(
                          'email: ${document['user']}, url: ${document['url']}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhotoInfo(
                                    email: document['user'],
                                    url: document['url'],
                                    hashTags: document['hashtags'],
                                    uploadTime: document['date'],
                                  )));
                    },
                  );
                },
              ).toList(),
            );
        }
      },
    );
  }
}
