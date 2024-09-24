

import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE6E8FF),
        // backgroundColor: Color(0xFF2F365F),
        title: Row(
          children: [
            Image.asset(
              'resources/image/BTRgov-logo.png', // Path to your logo
              height: 50, // Adjust height as needed
            ),
            SizedBox(width: 8), // Space between logo and title
            // Text(
            //   'Add Farmer',
            //   style: TextStyle(color: Colors.black), // Text color
            // ),
          ],
        ),
        centerTitle: false, // Center title is false since we are using Row

      ),
      backgroundColor: Colors.white, // Set the background color of the Scaffold
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('Coming Soon!!', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}