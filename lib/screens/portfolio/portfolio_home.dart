import 'package:flutter/material.dart';
import 'package:tasvat/app_constants.dart';
import 'package:tasvat/screens/portfolio/portfolio_assets.dart';
import 'package:tasvat/screens/portfolio/portfolio_transactions.dart';
import 'package:tasvat/screens/portfolio/portfolio_withdraw_orders.dart';
import '../../widgets/tabs.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  int _currentTabNumber = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: background,
        title: const Text(
          'Portfolio',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// for brief account details
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: RadialGradient(
                // focal: Alignment.bottomRight,
                center: Alignment.bottomRight,
                radius: 1.45,
                colors: [
                  accent2,
                  greyShade2,
                ],
                // stops: const [
                //   0.7,
                //   0.50,
                // ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Gold Asset',
                  style: TextStyle(
                    color: text400,
                    fontSize: body1,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '30.0',
                      style: TextStyle(
                        fontSize: 48,
                        color: text500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'MACE',
                      style: TextStyle(
                        fontSize: caption,
                        color: text500,
                      ),
                    ),
                  ],
                ),
                // RichText(
                //   textAlign: TextAlign.start,
                //   text: TextSpan(
                //     text: '30.0',
                //     style: TextStyle(
                //       fontSize: 48,
                //       color: text500,
                //       fontWeight: FontWeight.w600,
                //     ),
                //     children: [
                //       TextSpan(
                //         text: 'MACE',
                //         style: TextStyle(
                //           fontSize: caption,
                //           color: text500,
                //         ),
                //
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 10),
                Text(
                  '~ 9,000.00USD',
                  style: TextStyle(
                    color: text200,
                    fontSize: body2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          /// tabs for various pages for portfolio
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TabForDashboard(
                  currentTabNumber: _currentTabNumber,
                  label: 'Assets',
                  tabNumber: 0,
                  onPressed: () {
                    setState(() {
                      _currentTabNumber = 0;
                    });
                    _pageController.jumpToPage(_currentTabNumber);
                  },
                ),
                const SizedBox(width: 10),
                TabForDashboard(
                  currentTabNumber: _currentTabNumber,
                  label: 'Withdraw Orders',
                  tabNumber: 1,
                  onPressed: () {
                    setState(() {
                      _currentTabNumber = 1;
                    });
                    _pageController.jumpToPage(_currentTabNumber);
                  },
                ),
                const SizedBox(width: 10),
                TabForDashboard(
                  currentTabNumber: _currentTabNumber,
                  label: 'Transactions',
                  tabNumber: 2,
                  onPressed: () {
                    setState(() {
                      _currentTabNumber = 2;
                    });
                    _pageController.jumpToPage(_currentTabNumber);
                  },
                ),
              ],
            ),
          ),

          /// pageview for various screens
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: text100,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: PageView(
                controller: _pageController,
                children: [
                  PortfolioAssets(),
                  PortfolioWithdrawOrders(),
                  PortfolioTransactions(),
                ],
                onPageChanged: (int pageIndex) {
                  setState(() {
                    _currentTabNumber = pageIndex;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
