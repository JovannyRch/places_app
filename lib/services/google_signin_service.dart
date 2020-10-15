import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';

class GoogleSignInService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['email', 'profile']);

  static Future<User> signInWithGoogle() async {
    var errorMessage;

    /*  try {
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      print(account);

      return account;
    } catch (e) {
      print(e);
      return null;
    } */

    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);

        print('signInWithGoogle succeeded: $user');
      }
      return user;
    } on PlatformException catch (e) {
      if (Platform.isAndroid) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            print(e);
            break;
          case 'The password is invalid or the user does not have a password.':
            print(e);
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            print(e);
            break;
          default:
            print('Case ${e.message} is not yet implemented');
        }
      } else if (Platform.isIOS) {
        switch (e.code) {
          case 'Error 17011':
            print(e);
            break;
          case 'Error 17009':
            print(e);
            break;
          case 'Error 17020':
            print(e);
            break;
          // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      }
    }
    /* on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }  */
    catch (e) {
      print('error $e');
      return null;
    }
  }
}
