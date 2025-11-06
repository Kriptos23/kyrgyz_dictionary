import 'package:firebase_auth/firebase_auth.dart';
import 'package:kyrgyz_dictionary/classes/our_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  OurUser? _userFromFirebase(User user1) //this method so that we use our own user which has less garbage information
  {
    return user1 != null ? OurUser(uid: '${user1.uid}') : null;//creates OurUser obj from Firebase user obj
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
