import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static AuthService instance = AuthService();
  FirebaseAuth auth = FirebaseAuth.instance;


  bool isLoggedInWithEmail() {
    if (auth.currentUser == null) {
      return false;
    } else {
      return !auth.currentUser!.isAnonymous;
    }
  }

}