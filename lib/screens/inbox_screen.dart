import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search button click
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 100,
              child: Text('Placeholder for inbox messages'),
            ),
            Container(
              height: 100,
              child: Text('Placeholder for inbox messages'),
            ),
            Container(
              height: 100,
              child: Text('Placeholder for inbox messages'),
            ),
          ],
        ),
      ),
    );
  }
}
