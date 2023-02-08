import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex_flutter/bloc/listeners/auth_login_listener.dart';

import '../listeners/auth_registration_listener.dart';

class AuthRepository {

  void loginUser({
    required String email,
    required String password,
    required AuthLoginListener authLoginListener
  }) async {
    var authInstance = FirebaseAuth.instance;
    try{
      await authInstance.signInWithEmailAndPassword(email: email, password: password);
      authLoginListener.success();
    }
    on FirebaseAuthException catch (e){
      switch (e.code){
        case "invalid-credential":
          print("Invalid credential used to sign up");
          authLoginListener.invalidCredential();
          break;
        case "wrong-password":
          print("Incorrect password.");
          authLoginListener.wrongPassword();
          break;
        case "user-not-found":
          print("User not found");
          authLoginListener.userNotFound();
          break;
        default:
          print("Login failed");
          authLoginListener.failed();
      }
    }
    catch (e, trace){
      print(e);
      authLoginListener.failed();
    }
  }

  void registerUser({
    required String email,
    required String password,
    required String name,
    required AuthRegistrationListener authRegistrationListener
  }) async {
    var authInstance = FirebaseAuth.instance;
    try {
      await authInstance.createUserWithEmailAndPassword(email: email, password: password);
      //userCredential.user?.sendEmailVerification();
      //authInstance.signOut();
      authRegistrationListener.success();
    } on FirebaseAuthException catch (e) {
      switch(e.code){
        case 'weak-password':
          print('The password provided is too weak.');
          authRegistrationListener.weakPassword();
          break;
        case 'email-already-in-use':
          print('The account already exists for that email.');
          authRegistrationListener.userExists();
          break;
        default:
          print("Registering user failed");
          authRegistrationListener.failed();
      }
    }
    catch (e) {
      print(e);
      authRegistrationListener.failed();
    }
  }

}