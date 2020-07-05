//<----------this provides all the authentication srvices---------->

import 'package:PicToShare/misc/sharedpref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult res = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (res.user.isEmailVerified) {
        SharedPrefs().saveData('email', res.user.email);
        SharedPrefs().saveData('photourl', res.user.photoUrl);
        return res.user.email;
      }
      return 'email not verified';
    } catch (e) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'user not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'password not valid.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'Network error.';
          break;

        // ...
        default:
          return 'no problems';
      }
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    AuthResult res = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    Firestore.instance.collection('user').document(res.user.email).setData(
      {
        'uid': res.user.uid,
        'email': res.user.email,
        'username': res.user.email,
        'isPhoneVer': false
      },
    );
    SharedPrefs().saveData('email', res.user.email);
    SharedPrefs().saveData('photourl', res.user.photoUrl);
    try {
      await res.user.sendEmailVerification();
      return res.user.email;
    } catch (e) {
      print("An error occured while trying to send email        verification");
      print(e.message);
    }
  }

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
      if (account == null)
        return false; // if false no google account as such exist
      AuthResult res = await _auth.signInWithCredential(
        //if true getting credentials of the account
        GoogleAuthProvider.getCredential(
          idToken: (await account.authentication).idToken,
          accessToken: (await account.authentication).accessToken,
        ),
      );

      print('user info : ${res.user}');

      if (res.user == null) return null;
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
      return null;
    }
  }
}
