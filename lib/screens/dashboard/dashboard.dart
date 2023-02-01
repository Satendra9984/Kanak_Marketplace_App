import 'package:flutter/material.dart';
import 'package:tasvat/utils/app_constants.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: const Color(0XFF141414),
        elevation: 0.0,
        title: const Text(
          'Tasvat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: const CircleAvatar(
              // borderRadius: BorderRadius.circular(100),
              radius: 16,
              backgroundImage: AssetImage(
                'assets/images/a_man_reading.png',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
