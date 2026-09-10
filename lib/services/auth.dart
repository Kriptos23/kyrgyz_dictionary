import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:kyrgyz_dictionary/classes/our_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kyrgyz_dictionary/services/firestore_cloud_database.dart';

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
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      if (user == null) return null;

      // Await the creation of default data
      DatabaseService databaseService = DatabaseService(uid: user.uid);
      await databaseService.createUserDataOnFirstLogin();

      return _userFromFirebase(user); // now it's safe
    } catch (e) {
      print(e.toString());
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
      // final userCredential = await _auth.signInWithPopup(googleProvider);
      // await _auth.setPersistence(Persistence.LOCAL); // must be called BEFORE redirect
      await FirebaseAuth.instance.signInWithRedirect(googleProvider);
      // handleRedirect();

      // return null;
      // ✅ Sign in to Firebase
      // final user = userCredential.user;
      //
      // DatabaseService databaseService = DatabaseService(uid: user!.uid);
      // databaseService.createUserDataOnFirstLogin();
      //
      // print('Signed in as: ${userCredential.user?.email}');
      // return userCredential;

    }catch(e){
      print(e.toString());
      return null;
    }
  }


  // Future<OurUser?> signInWithGoogleMobile() async{
  //   try {
  //
  //     // ✅ Initialize Google Sign-In
  //     await _googleSignIn.initialize(serverClientId: "308251536087-2o97glujvbvhfgglea6hsugs20q6urdf.apps.googleusercontent.com");
  //
  //     // ✅ Start the authentication flow
  //     final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
  //
  //     // ✅ Get Google tokens
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //
  //     // ✅ Create Firebase credential
  //     final credential = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken,
  //       // accessToken: googleAuth.idToken,
  //     );
  //
  //     // ✅ Sign in to Firebase
  //     final userCredential = await _auth.signInWithCredential(credential);
  //     final user = userCredential.user;
  //
  //     ///Here we are creating collections and documents for the levels counter and more
  //     DatabaseService databaseService = DatabaseService(uid: user!.uid);
  //     databaseService.createUserDataOnFirstLogin();
  //
  //     return _userFromFirebase(user!);
  //   } catch (e) {
  //     print('Google Sign-In error: $e');
  //     return null;
  //   }
  // }

  Future<OurUser?> signInWithGoogleMobile() async {
    try {
      await _googleSignIn.initialize(
        serverClientId: '308251536087-2o97glujvbvhfgglea6hsugs20q6urdf.apps.googleusercontent.com',
      );

      final GoogleSignInAccount googleUser =
      await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) return null;

      final databaseService = DatabaseService(uid: user.uid);
      await databaseService.createUserDataOnFirstLogin();

      return _userFromFirebase(user);
    } catch (e) {
      print('Google Sign-In error: $e');
      return null;
    }
  }

  Future<String?> get uid async{
    final user = await signInWithGoogleMobile();
    return user?.uid;
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

  Future<void> handleRedirect() async {
    if (!kIsWeb) return; // skip on mobile

    final result = await FirebaseAuth.instance.getRedirectResult();

    try{
    if (result.user != null) {
      print("Redirect success: ${result.user!.email}");

      await DatabaseService(uid: result.user!.uid)
          .createUserDataOnFirstLogin();
    }
    else{
      print('no error, not user as well');
    }
  } catch (e) {
  print("Redirect error: $e");
  }
  }

  Future<void> setPersistence() async {
    // ✅ Keep user signed in across tabs and browser reloads
    await _auth.setPersistence(Persistence.LOCAL);
  }



}