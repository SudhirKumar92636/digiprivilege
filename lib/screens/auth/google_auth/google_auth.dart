// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class SigningController extends GetxController {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   RxBool isLoading = false.obs; // Use RxBool for loading state
//
//   Future<void> signInWithGoogle() async {
//     isLoading.value = true; // Set loading to true
//     try {
//       final GoogleSignInAccount? googleUserAccount = await _googleSignIn.signIn();
//       if (googleUserAccount == null) {
//         isLoading.value = false; // Set loading to false
//         Get.snackbar("Sign-in", "Sign-in cancelled.");
//         return;
//       }
//
//       final GoogleSignInAuthentication googleSignInAuth =
//       await googleUserAccount.authentication;
//
//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuth.accessToken,
//         idToken: googleSignInAuth.idToken,
//       );
//
//       await FirebaseAuth.instance.signInWithCredential(credential);
//
//       isLoading.value = false; // Set loading to false
//       print("✅ Login Successful");
//       Get.snackbar("Sign-in", "Sign-in successful.");
//       // Navigate to the next screen or perform other actions
//     } catch (ex) {
//       isLoading.value = false; // Set loading to false
//       print("❌ Exception: ${ex.toString()}");
//       Get.snackbar("Sign-in", "Sign-in failed: ${ex.toString()}");
//     }
//   }
// }





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../landing_page.dart';
import '../../profile/UserDetailsScreen.dart';

class SigningController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  RxBool isLoading = false.obs; // Loading state

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUserAccount = await _googleSignIn.signIn();
      if (googleUserAccount == null) {
        isLoading.value = false;
        Get.snackbar("Sign-in", "Sign-in cancelled.");
        return;
      }

      final GoogleSignInAuthentication googleSignInAuth =
      await googleUserAccount.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      String email = userCredential.user?.email ?? "";

      if (email.isNotEmpty) {
        await checkUserExists(email);
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "Email not found.");
      }
    } catch (ex) {
      isLoading.value = false;
      print("❌ Exception: ${ex.toString()}");
      Get.snackbar("Sign-in", "Sign-in failed: ${ex.toString()}");
    }
  }

  Future<void> checkUserExists(String email) async {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users') // Ensure this collection matches your Firestore setup
          .where('email', isEqualTo: email)
          .get();

      if (userDoc.docs.isEmpty) {
        newUserPage();
      } else {
        goLandingPage();
      }
    } catch (e) {
      print("❌ Firestore Error: ${e.toString()}");
      Get.snackbar("Error", "Failed to check user.");
    } finally {
      isLoading.value = false;
    }
  }

  void goLandingPage() {
    Get.offAll(() => LandingPage()); // GetX navigation
  }

  void newUserPage() {
    Get.offAll(() => UserDetailsScreen(mobile: FirebaseAuth.instance.currentUser?.phoneNumber ?? ""));
  }
}
