//<----------this is provides al the authentication srvices---------->

import 'package:PicToShare/misc/sharedpref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error logging out");
    }
  }

  Future loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false; // if false no google account as such exist
      AuthResult res = await _auth.signInWithCredential(  //if true getting credentials of the account
        GoogleAuthProvider.getCredential(
          idToken: (await account.authentication).idToken,
          accessToken: (await account.authentication).accessToken,
        ),
      );
      print('user info : ${res.user}');

      if (res.user == null) return false;
      print(res.user.displayName);
      print(res.user.email);
      print(res.user.uid);
      Firestore.instance.collection('user').document(res.user.email).setData(
        {
          'uid': res.user.uid,
          'email': res.user.email,
          'username': res.user.displayName,
          'isPhoneVer': false
        },
      );
      SharedPrefs().saveData('email', res.user.email);
      SharedPrefs().saveData('photourl', res.user.photoUrl);
      return res.user.email;
    } catch (e) {
      print(e.message);
      print("Error logging with google");
      return false;
    }
  }
}
