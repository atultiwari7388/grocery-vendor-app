import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_vendor_app/Screens/OnBoardScreen/onboard_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              children: [
                Positioned(
                  right: 0.0,
                  top: 10.0,
                  child: TextButton(
                    child: Text("Skip"),
                    onPressed: () {},
                  ),
                ),
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
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
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
