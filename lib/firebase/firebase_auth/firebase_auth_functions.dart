import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthFunctions {
  //Singleton-Object

  FirebaseAuthFunctions._internal();
  static FirebaseAuthFunctions instance = FirebaseAuthFunctions._internal();
  factory FirebaseAuthFunctions() => instance;

  //Register User to Firebase
  Future<dynamic> regsiterNewUser(
  String userName, String userEmail, String userPassword) async {
  try {
    
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userEmail, 
      password: userPassword,
    );

    
    await FirebaseAuth.instance.currentUser!.updateProfile(
      displayName: userName,
    );

    
    await FirebaseAuth.instance.currentUser!.reload();
    final updatedUser = FirebaseAuth.instance.currentUser;

    return updatedUser;
  } on FirebaseAuthException catch (e) {
    
    return e;
  }
}


  //Authenticate User with Firebase
  Future<dynamic> authenticateUser(
      String userEmail, String userPassword) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPassword);
      final user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }
  Future<void> signOutUser() async{ 
    await FirebaseAuth.instance.signOut();
  }
}
