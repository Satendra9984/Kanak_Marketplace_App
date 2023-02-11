import 'package:flutter/material.dart';
import 'package:tasvat/screens/profile/views/profile_home_screen.dart';
import 'package:tasvat/utils/app_constants.dart';
import 'package:tasvat/widgets/gold_rate_graph.dart';

import '../../widgets/tabs.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentTabNumber = 0;

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
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ProfileScreen(),
                  ),
                );
              },
              child: const CircleAvatar(
                // borderRadius: BorderRadius.circular(100),
                radius: 16,
                backgroundImage: AssetImage(
                  'assets/images/a_man_reading.png',
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),

            /// Free Gifts
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: text100,
                gradient: RadialGradient(
                  center: Alignment.bottomCenter,
                  radius: 0.66,
                  colors: [
                    accent2.withOpacity(0.65),
                    text100,
                  ],
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Free gifts for newbies',
                          style: TextStyle(
                            color: accent2,
                            fontSize: title,
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: true,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'I want it ->',
                            style: TextStyle(
                              color: text400,
                              fontSize: body1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Image.asset(
                      'assets/images/gift_box.png',
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// Real-Time gold price data
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: text100,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Tab Menu
                  Container(
                    // alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: background,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TabForDashboard(
                          currentTabNumber: _currentTabNumber,
                          label: 'Buy Price',
                          tabNumber: 0,
                          onPressed: () {
                            setState(() {
                              _currentTabNumber = 0;
                            });
                            // _pageController.jumpToPage(_currentTabNumber);
                          },
                          backgroundColor: background,
                        ),
                        TabForDashboard(
                          currentTabNumber: _currentTabNumber,
                          label: 'Sell Price',
                          tabNumber: 1,
                          onPressed: () {
                            setState(() {
                              _currentTabNumber = 1;
                            });
                            // _pageController.jumpToPage(_currentTabNumber);
                          },
                          backgroundColor: background,
                        ),
                      ],
                    ),
                  ),
                  // Some Titles
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Text(
                          'Market Overview',
                          style: TextStyle(
                            color: text500,
                            fontSize: body1,
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: true,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Rupees per gram',
                          style: TextStyle(
                            color: text300,
                            fontSize: body2,
                            fontWeight: FontWeight.w500,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),

                  // TODO: GOLD PRICE GRAPH
                  // GoldRateGraph(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
