import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../home/home_screen.dart';
import '../inbox/inbox_screen.dart';
import '../my_booking/my_booking_screen.dart';
import '../profile/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  // Boshlang'ich tanlangan qism

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), // Home screen uchun vidjet
    MyBookingScreen(), // My Booking screen uchun vidjet
    InboxScreen(), // Inbox screen uchun vidjet
    ProfileScreen(), // Profile screen uchun vidjet
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey[500],
        selectedItemColor: Colors.amber[800],
        selectedLabelStyle: TextStyle(
          color: Colors.amber[500],
        ),
        elevation: 4.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home_outline),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.calendar_outline),
            label: 'My Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.message_outline),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_circle_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
