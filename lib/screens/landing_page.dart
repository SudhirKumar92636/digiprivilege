import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'book_stay/stays.dart';
import 'home/screens/home_fragment.dart';
import 'profile/components/profile_fragment.dart';
import 'user_membership/MembershipsFragment.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final bool _isDay = true;

  int pageIndex = 0;
  final pages = [
    const HomeFragment(),
    const MembershipsFragment(),
    const Stays(),
    const ProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = _isDay == true ? Colors.black : Colors.white;
    var activeTheme = _isDay == true ? Colors.white : Colors.black;
    return Scaffold(
        body: pages[pageIndex],
        backgroundColor: Colors.black,
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: theme,
          itemCornerRadius: 10,
          selectedIndex: pageIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            pageIndex = index;
          }),
          items: [
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              inactiveColor: _isDay == true ? Colors.white : Colors.black,
              activeColor: activeTheme,
            ),
            BottomNavyBarItem(
                icon: const Icon(Icons.work_rounded),
                title: const Text('Memberships'),
                activeColor: activeTheme),
            BottomNavyBarItem(
                icon: const Icon(Icons.bookmarks_rounded),
                title: const Text('My Bookings'),
                activeColor: activeTheme),
            BottomNavyBarItem(
                icon: const Icon(Icons.person),
                title: const Text('Profile'),
                activeColor: activeTheme),
          ],
        ));
  }
}