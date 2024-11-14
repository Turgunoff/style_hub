import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Profile Name: John Doe'),
            Text('Email: johndoe@example.com'),
            Text('Age: 30'),
            Text('Gender: Male'),
            Text('Address: 123 Main St, City, State, Zip'),
          ],
        ),
      ),
    );
  }
}
