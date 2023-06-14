import 'package:cryptotracker_app/shared/theme.dart';
import 'package:cryptotracker_app/ui/pages/home/home_page.dart';
import 'package:cryptotracker_app/ui/pages/favorite/favorite_page.dart';
import 'package:cryptotracker_app/ui/pages/news/news_page.dart';
import 'package:cryptotracker_app/ui/pages/account/account_page.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  var currentIndex = 0;
  List pages = [
    const HomePage(),
    const FavoritePage(),
    const NewsPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20),
        height: deviceWidth(context) * .155,
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding:
              EdgeInsets.symmetric(horizontal: deviceWidth(context) * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  currentIndex = index;
                },
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom:
                        index == currentIndex ? 0 : deviceWidth(context) * .029,
                    right: deviceWidth(context) * .0422,
                    left: deviceWidth(context) * .0422,
                  ),
                  width: deviceWidth(context) * .128,
                  height:
                      index == currentIndex ? deviceWidth(context) * .014 : 0,
                  decoration: const BoxDecoration(
                    color: primaryNavbarColor,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                Icon(
                  listOfIcons[index],
                  size: deviceWidth(context) * .076,
                  color: index == currentIndex
                      ? primaryNavbarColor
                      : secondaryNavbarColor,
                ),
                SizedBox(height: deviceWidth(context) * .03),
              ],
            ),
          ),
        ),
      ),
      body: pages[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.newspaper_rounded,
    Icons.person_rounded,
  ];
}
