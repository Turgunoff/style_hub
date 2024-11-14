import 'package:flutter/material.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Booking'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Handle calendar button press
            },
          ),
        ],
      ),
      body: Center(
        child: Text('My Booking Screen'),
      ),
    );
  }
}
