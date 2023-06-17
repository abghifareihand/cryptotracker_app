import 'package:cryptotracker_app/providers/auth_provider.dart';
import 'package:cryptotracker_app/providers/coin_provider.dart';
import 'package:cryptotracker_app/providers/news_provider.dart';
import 'package:cryptotracker_app/ui/pages/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CoinProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
