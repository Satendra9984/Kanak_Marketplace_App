import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF141414),
        elevation: 0.0,
        title: const Text(
          'Hello Tasvat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        actions: [
          ClipRRect(
            child: IconButton(
              onPressed: () {
                // navigate to profile screen
              },
              icon: const Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: Container(
        child: Text('Gold prices'),
      ),
    );
  }
}
