import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasvat/app_constants.dart';
import 'package:tasvat/screens/dashboard/dashboard.dart';
import 'package:tasvat/screens/portfolio/portfolio_home.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSelectedBottomNavItem = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF141414),
      body: PageView(
        controller: _pageController,
        children: [
          DashboardScreen(),
          PortfolioHome(),
          PortfolioHome(),
        ],
        onPageChanged: (int index) {},
      ),
      floatingActionButton: Container(
        // alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: text150,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _currentSelectedBottomNavItem = 0;
                  _pageController.jumpToPage(0);
                });
              },
              child: CircleAvatar(
                maxRadius: 24,
                backgroundColor:
                    _currentSelectedBottomNavItem == 0 ? accent2 : text150,
                child: const Icon(
                  Icons.home,
                  size: 32,
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _currentSelectedBottomNavItem = 1;
                  _pageController.jumpToPage(1);
                });
              },
              child: CircleAvatar(
                maxRadius: 24,
                backgroundColor:
                    _currentSelectedBottomNavItem == 1 ? accent2 : text150,
                child: const Icon(
                  FontAwesomeIcons.arrowsUpDown,
                  size: 32,
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _currentSelectedBottomNavItem = 2;
                  _pageController.jumpToPage(2);
                });
              },
              child: CircleAvatar(
                maxRadius: 24,
                backgroundColor:
                    _currentSelectedBottomNavItem == 2 ? accent2 : text150,
                child: const Icon(
                  Icons.window,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   // margin: const EdgeInsets.only(bottom: 15, left: 80, right: 80),
      //   child: ClipRRect(
      //     // borderRadius: BorderRadius.circular(80),
      //     child: BottomNavigationBar(
      //       currentIndex: _currentSelectedBottomNavItem,
      //       iconSize: 24,
      //       // we have made it a variable so that selected item will be highlighted otherwise no means to notify
      //       selectedItemColor: Colors.black,
      //       unselectedItemColor: Colors.grey.shade600,
      //       // type: BottomNavigationBarType.shifting,
      //       showSelectedLabels: false,
      //       showUnselectedLabels: false,
      //       backgroundColor: text150,
      //       elevation: 15,
      //       items: [
      //         BottomNavigationBarItem(
      //           icon: CircleAvatar(
      //             maxRadius: 24,
      //             backgroundColor:
      //                 _currentSelectedBottomNavItem == 0 ? accent2 : text150,
      //             child: const Icon(
      //               Icons.home,
      //               size: 32,
      //             ),
      //           ),
      //           label: 'Home',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: CircleAvatar(
      //             maxRadius: 24,
      //             backgroundColor:
      //                 _currentSelectedBottomNavItem == 1 ? accent2 : text150,
      //             child: const Icon(
      //               FontAwesomeIcons.arrowsUpDown,
      //               size: 32,
      //             ),
      //           ),
      //           label: 'sell/buy',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: CircleAvatar(
      //             maxRadius: 24,
      //             backgroundColor:
      //                 _currentSelectedBottomNavItem == 2 ? accent2 : text150,
      //             child: const Icon(
      //               Icons.window,
      //               size: 32,
      //             ),
      //           ),
      //           label: 'portfolio',
      //         ),
      //       ],
      //       onTap: (screen) {
      //         setState(() {
      //           _currentSelectedBottomNavItem = screen;
      //           _pageController.jumpToPage(screen);
      //         });
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
