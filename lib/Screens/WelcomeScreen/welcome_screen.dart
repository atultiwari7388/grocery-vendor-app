import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_vendor_app/Screens/OnBoardScreen/onboard_screen.dart';
// import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  // ignore: unused_field
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
                    TextField(
                      decoration: InputDecoration(
                        prefixText: "+91",
                        prefixStyle: GoogleFonts.aBeeZee(
                          color: Colors.grey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        labelText: "10 digit phone number",
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      autofocus: true,
                      controller: _phoneNumberController,
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
                    Row(
                      children: [
                        Expanded(
                            child: AbsorbPointer(
                          absorbing: _validPhoneNumber ? false : true,
                          child: ElevatedButton(
                            child: Text(
                              _validPhoneNumber
                                  ? "Continue"
                                  : "Ennter Your Number",
                            ),
                            onPressed: () {
                              // ignore: unnecessary_statements
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
}
