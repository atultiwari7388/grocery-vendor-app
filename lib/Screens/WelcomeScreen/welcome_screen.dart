import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_vendor_app/Screens/OnBoardScreen/onboard_screen.dart';
import 'package:grocery_vendor_app/Services/auth_service.dart';
import 'package:otp_text_field/otp_text_field.dart';

class WelcomeScreen extends StatefulWidget {
  // ignore: unused_field
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthProvider>(context);
    bool _validPhoneNumber = false;
    var _phoneNumberController = TextEditingController();

    void showBottomSheet(context) {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, StateSetter myState) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LOGIN",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Enter Your Phone Number to Process",
                      style: GoogleFonts.aBeeZee(),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixText: "+91",
                        prefixStyle: GoogleFonts.aBeeZee(
                          color: Colors.grey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: InkWell(
                          onTap: wait
                              ? null
                              : () async {
                                  myState(() {
                                    start = 30;
                                    wait = true;
                                    buttonName = "Resend";
                                  });
                                  await authClass.verifyPhoneNumber(
                                      "+91 ${phoneController.text}",
                                      context,
                                      setData);
                                },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            child: Text(
                              buttonName,
                              style: TextStyle(
                                color: wait ? Colors.black : Colors.green,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        labelText: "10 digit phone number",
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      autofocus: true,
                      controller: phoneController,
                      onChanged: (value) {
                        if (value.length == 10) {
                          myState(() {
                            _validPhoneNumber = true;
                          });
                        } else {
                          myState(() {
                            _validPhoneNumber = false;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    otpField(),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: AbsorbPointer(
                          absorbing: _validPhoneNumber ? false : true,
                          child: ElevatedButton(
                            child: Text(
                              _validPhoneNumber
                                  ? "Verify OTP"
                                  : "Ennter Your Number",
                            ),
                            onPressed: () {
                              authClass.signInwithPhoneNumber(
                                verificationIdFinal,
                                smsCode,
                                context,
                              );
                            },
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(child: OnBoardScreen()),
                Text(
                  "Order from your nearest shop ?",
                  style: GoogleFonts.aBeeZee(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Set Delivery Location",
                    style: GoogleFonts.aBeeZee(),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showBottomSheet(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already a Customer ? ",
                      style: GoogleFonts.aBeeZee(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget otpField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OTPTextField(
        length: 6,
        width: MediaQuery.of(context).size.width - 34,
        fieldWidth: 38,
        otpFieldStyle: OtpFieldStyle(
          backgroundColor: Colors.green,
          borderColor: Colors.green,
        ),
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        // fieldStyle: FieldStyle.underline,
        onCompleted: (pin) {
          print("Completed: " + pin);
          setState(() {
            smsCode = pin;
          });
        },
      ),
    );
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    // startTimer();
  }
}
