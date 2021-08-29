import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

// create pageview controller
final _controller = PageController(
  initialPage: 0,
);

int _currentPage = 0;

// create list of pages

List<Widget> _pages = [
  Column(
    children: [
      Expanded(child: Image.asset("assets/location.gif")),
      Text(
        "Set Your Delivery Location",
        style: GoogleFonts.aBeeZee(fontSize: 25.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset("assets/foodorder.gif")),
      Text(
        "Order Online From Your Favorite Store",
        style: GoogleFonts.aBeeZee(fontSize: 25.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset("assets/doorstepdelivery.gif")),
      Text(
        "Quick Delivery to Your Doorstep",
        style: GoogleFonts.aBeeZee(fontSize: 25.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ],
  )
];

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            children: _pages,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        SizedBox(height: 30),
        DotsIndicator(
          dotsCount: _pages.length,
          position: _currentPage.toDouble(),
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            activeColor: Colors.green,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
