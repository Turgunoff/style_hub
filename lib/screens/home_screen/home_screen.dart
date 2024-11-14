import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Style Hub'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.notification_outline,
              size: 24,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Welcome to the Home Screen!'),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
