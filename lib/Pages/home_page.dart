import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                // top heading and
                buildAppBar(),
                SizedBox(height: 20),
                buildSearchBar(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Grocery App",
              style: GoogleFonts.aBeeZee(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 20.00,
              ),
            ),
            CircleAvatar(
              radius: 20,
              child: Icon(Icons.shopping_bag),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    var searchProducts = [
      "Fresh Vegetable",
      "Fresh Fruits",
      "Fresh Apples",
      "Mango",
      "Cucumber",
      "Banana",
    ];

    final _random = new Random();

    var products = searchProducts[_random.nextInt(searchProducts.length)];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.lightGreen.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.green,
            size: 28.0,
          ),
          SizedBox(width: 5),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.filter_list,
                  color: Colors.green,
                ),
                border: InputBorder.none,
                hintText: "Search $products",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
