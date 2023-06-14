import 'dart:async';

import 'package:cryptotracker_app/shared/theme.dart';
import 'package:cryptotracker_app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavbar(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Container(
          width: 420,
          height: 56,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo_splash.png'),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Text(
          'Abghi Fareihan',
          style: greyTextStyle.copyWith(
            fontSize: 16,
            fontWeight: light,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
