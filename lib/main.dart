import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/screens/home_screen.dart';
import 'package:tasvat/screens/portfolio/portfolio_home.dart';

void main() {
  runApp(const Tasvat());
}

class Tasvat extends StatelessWidget {
  const Tasvat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
      // home: PortfolioHome(),
    );
  }
}
// https://www.behance.net/gallery/139996351/Goldia-Gold-Trading-Mobile-App
