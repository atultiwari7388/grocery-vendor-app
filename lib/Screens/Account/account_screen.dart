import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_vendor_app/Screens/WelcomeScreen/welcome_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 150),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    'Logout',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.logout),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ),
                        (route) => false);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
