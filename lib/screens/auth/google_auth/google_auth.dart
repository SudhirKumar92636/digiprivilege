import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SigningController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUserAccount = await _googleSignIn.signIn();
      if (googleUserAccount == null) return; // ✅ User cancelled sign-in

      final GoogleSignInAuthentication googleSignInAuth = await googleUserAccount.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      print("✅ Login Successful");

    } catch (ex) {
      print("❌ Exception: ${ex.toString()}");
    }
  }
}