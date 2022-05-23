import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticateService {
  final FirebaseAuth _firebaseAuth;

  AuthenticateService(this._firebaseAuth);

  Future<String> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Sucessfully Registerd";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<bool> googleLogin() async {
    final user = await GoogleSignIn().signIn();
    if (user == null) return false;

    final googleAuth = await user.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    return true;
  }
}
