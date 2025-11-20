import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:kyrgyz_dictionary/classes/our_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  OurUser? _userFromFirebase(User user1) //this method so that we use our own user which has less garbage information
  {
    return user1 != null ? OurUser(uid: '${user1.uid}') : null;//creates OurUser obj from Firebase user obj
  }
  OurUser? _userFromFirebase2(String id) //this method so that we use our own user which has less garbage information
  {
    // OurUser user2 != null ? OurUser(uid: id) : null;//creates OurUser obj from Firebase user obj
    // return user2;
    return id != null ? OurUser(uid: id) : null;
  }

  ///Насколько я понял, позже надо будет .listen() использовать на этом геттере, или можно Provider, SteamProvider заюзать
  ///чтобы было легче использовать вместо листен
  Stream<OurUser?> get user {//we indicated in the carrot brackets that we want it to return Stream of OurUser obj
    print('user getter is used');
    return _auth.authStateChanges().map((User? user) {
      return user != null ? _userFromFirebase(user) : null;
    });
    //return _auth.authStateChanges().map((User? user) =>_userFromFirebase(user!));
  }


  // sign in anon
  Future signInAnon() async //this is so that we can sign in anonymously
  {
    try {
      UserCredential result = await _auth.signInAnonymously();//method which signs user in anonymously
      User? user = result.user;//saves user from UserCredential into User obj, this user is not related to getter above
      return _userFromFirebase(user!);//returns our own user obj
    } catch (e) {
      print(e.toString());//catch if error
      return null;
    }
  }

// sign in Google
//   Future signInWithGoogle() async {
//     await _googleSignIn.initialize();
//     try {
//       final googleUser = await _googleSignIn.authenticate();
//       final GoogleSignInAuthentication googleAuth = googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
//       String userid = googleUser.id;
//       return await FirebaseAuth.instance.signInWithCredential(credential);
//       return _userFromFirebase2(userid);
//     }
//     catch(e){
//       print(e.toString());
//       return null;
//     }
//
//   }
  Future<OurUser?> signInWithGoogle() async {
    if (kIsWeb) {
      // ✅ Web version
      await signInWithGoogleWeb();
    } else {
      // ✅ Mobile version
      await signInWithGoogleMobile();
    }

  }

  Future<UserCredential?> signInWithGoogleWeb() async {
    try {
      // ✅ Create a GoogleAuthProvider instance
      final googleProvider = GoogleAuthProvider();

      // Optionally add scopes if you need more than just basic profile
      // googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');

      // ✅ Trigger a popup sign-in flow
      final userCredential = await _auth.signInWithPopup(googleProvider);

      print('Signed in as: ${userCredential.user?.email}');
      return userCredential;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<OurUser?> signInWithGoogleMobile() async{
    try {

      // ✅ Initialize Google Sign-In
      await _googleSignIn.initialize(serverClientId: "308251536087-2o97glujvbvhfgglea6hsugs20q6urdf.apps.googleusercontent.com");

      // ✅ Start the authentication flow
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // ✅ Get Google tokens
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // ✅ Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        // accessToken: googleAuth.idToken,
      );

      // ✅ Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      return _userFromFirebase(user!);
    } catch (e) {
      print('Google Sign-In error: $e');
      return null;
    }
  }

// sign out
  Future signOut() async
  {
    try{
     _auth.signOut();
     print("User signed out");
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
}
