import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_vendor_app/Screens/Home/home_screen.dart';
import 'package:grocery_vendor_app/Services/user_service.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  late String smsOtp;
  late String verificationId;
  late String error = "";
  late UserServices _userServices = UserServices();

  Future<void> verifyPhone(BuildContext context, String number) async {
    final PhoneVerificationCompleted verificationComplted =
        (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      print(e.code);
    };

    final PhoneCodeSent smsOtpSend = (String verId, int? resendToken) async {
      this.verificationId = verId;

      // open dialog to enter received OTP SMS

      smsOtpDialog(context, number);
    };

    try {
      _auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: number,
        verificationCompleted: verificationComplted,
        verificationFailed: verificationFailed,
        codeSent: smsOtpSend,
        codeAutoRetrievalTimeout: (String verId) {
          this.verificationId = verId;
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic>? smsOtpDialog(BuildContext context, String number) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text("verification code"),
              SizedBox(height: 6),
              Text(
                "Enter 6 digit OTP",
                style: GoogleFonts.aBeeZee(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          content: Container(
            height: 85,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 6,
              onChanged: (value) {
                this.smsOtp = value;
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: smsOtp,
                  );
                  final User? user =
                      (await _auth.signInWithCredential(phoneAuthCredential))
                          .user;
                  // create user data in firestore after user successfully registered
                  _createUser(id: user!.uid, number: user.phoneNumber);

                  // Navigate to Home Page After Login
                  // ignore: unnecessary_null_comparison
                  if (user != null) {
                    Navigator.of(context).pop();

                    // dont want to comeback to welcome screen afetr logged in
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  } else {
                    print("Login Failed");
                  }
                } catch (e) {
                  this.error = "Invalid OTP";
                  print(e.toString());
                  Navigator.of(context).pop();
                }
              },
              child: Text("Verify"),
            ),
          ],
        );
      },
    );
  }

  void _createUser({String? id, String? number}) {
    _userServices.createUserData({
      'id': id,
      'number': number,
    });
  }
}
