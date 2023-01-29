import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSelectedBottomNavItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF141414),
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
      body: const Center(
        child: Text('1'),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 15, left: 80, right: 80),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: BottomNavigationBar(
            currentIndex: _currentSelectedBottomNavItem,
            iconSize: 24,
            // we have made it a variable so that selected item will be highlighted otherwise no means to notify
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.shade600,
            // type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: const Color(0XFF333333),
            elevation: 15,
            items: [
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  maxRadius: 24,
                  backgroundColor: _currentSelectedBottomNavItem == 0
                      ? Colors.yellow.shade500
                      : const Color(0XFF333333),
                  child: const Icon(
                    Icons.home,
                    size: 32,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  maxRadius: 24,
                  backgroundColor: _currentSelectedBottomNavItem == 1
                      ? Colors.yellow.shade500
                      : const Color(0XFF333333),
                  child: const Icon(
                    FontAwesomeIcons.arrowsUpDown,
                    size: 32,
                  ),
                ),
                label: 'sell/buy',
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  maxRadius: 24,
                  backgroundColor: _currentSelectedBottomNavItem == 2
                      ? Colors.yellow
                      : const Color(0XFF333333),
                  child: const Icon(
                    Icons.window,
                    size: 32,
                  ),
                ),
                label: 'portfolio',
              ),
            ],
            onTap: (screen) {
              setState(() {
                _currentSelectedBottomNavItem = screen;
                // _pageController.jumpToPage(screen);
              });
            },
          ),
        ),
      ),
    );
  }
}
