import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:alibtisam/network/org_id.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:logger/logger.dart';

class FirebaseOtpValidation {
  static late String _verificationId;
  static void verifyPhoneNumber(String phoneNumber) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Handle successful phone number verification
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'too-many-requests') {
          // Handle the specific error
          customSnackbar(message: 'Too many requests');
          // showTooManyRequestsDialog();
        } else {
          // Handle other errors
          Logger().w(e.message.toString());
          customSnackbar(message: e.message.toString());
          // showGenericErrorDialog(e.message);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        // Handle the code sent event
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle the timeout event
      },
    );
  }

  static Future<void> validateOTP({
    required String otp,
    required String email,
    required String password,
    required String mobile,
    required String name,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      // Create a PhoneAuthCredential with the verification ID and OTP
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );

      // Sign in with the credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      await ApiRequests().register(
          email: email,
          password: password,
          clubId: orgId,
          mobile: mobile,
          name: name);
      // User is signed in, you can access user information here
      print('User signed in: ${userCredential.user?.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        customSnackbar(message: 'Invalid OTP');
      } else {
        print('Error: ${e.message}');
      }
    }
  }
}
