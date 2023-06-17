import 'package:cryptotracker_app/shared/theme.dart';
import 'package:cryptotracker_app/ui/pages/account/account_page.dart';
import 'package:cryptotracker_app/ui/pages/favorite/favorite_page.dart';
import 'package:cryptotracker_app/ui/pages/home/home_page.dart';
import 'package:cryptotracker_app/ui/pages/news/news_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  List pages = [
    const HomePage(),
    const FavoritePage(),
    const NewsPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(),
      body: pages[_selectedIndex],
    );
  }

  Widget bottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: GNav(
          backgroundColor: Colors.white,
          color: greyColor,
          activeColor: primaryNavbarColor,
          tabBackgroundColor: primaryNavbarColor.withOpacity(0.15),
          gap: 10,
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            if (_selectedIndex != index) {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.home_rounded,
              text: 'Home',
            ),
            GButton(
              icon: Icons.favorite_rounded,
              text: 'Favorite',
            ),
            GButton(
              icon: Icons.newspaper_rounded,
              text: 'News',
            ),
            GButton(
              icon: Icons.person_rounded,
              text: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
