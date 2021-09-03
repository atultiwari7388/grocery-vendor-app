import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_vendor_app/Pages/home_page.dart';
import 'package:grocery_vendor_app/Screens/Account/account_screen.dart';
import 'package:grocery_vendor_app/Screens/Notifications/notification_screen.dart';
import 'package:grocery_vendor_app/Screens/Wishlist/wishlist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final screens = [
    HomePage(),
    WishList(),
    NotificationScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 50,
        // backgroundColor: Colors.green,
        selectedItemColor: Colors.green,
        // unselectedItemColor: Colors.green,
        // iconSize: 30,
        // selectedFontSize: 20,
        // selectedLabelStyle: GoogleFonts.aBeeZee(color: Colors.black),
        // unselectedFontSize: 20,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: "WishList",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: "Notifications",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
