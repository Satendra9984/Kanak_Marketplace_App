import 'package:flutter/material.dart';
import 'package:tasvat/screens/portfolio/gold_asset_details.dart';
import 'package:tasvat/screens/portfolio/portfolio_sell_list.dart';
import 'package:tasvat/utils/app_constants.dart';
import 'package:tasvat/screens/portfolio/portfolio_assets.dart';
import 'package:tasvat/screens/portfolio/portfolio_transactions.dart';
import 'package:tasvat/screens/portfolio/portfolio_withdraw_orders.dart';
import '../../widgets/tabs.dart';
import '../profile/views/profile_home_screen.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  late ScrollController _scrollController;
  int _currentTabNumber = 0;
  late PageController _pageController;

  @override
  void initState() {
    _scrollController = ScrollController();
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
          'Wallet',
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          /// for brief account details
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return const GoldAssetDetailsScreen();
                        },
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: text100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Gold Asset',
                          style: TextStyle(
                            color: text400,
                            fontSize: body2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '30.0',
                              style: TextStyle(
                                fontSize: heading2,
                                color: text500,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'GM',
                              style: TextStyle(
                                fontSize: caption,
                                color: text400,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: accentBG,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Cash Available',
                          style: TextStyle(
                            color: text400,
                            fontSize: body2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // const SizedBox(height: 10),

                        const SizedBox(height: 10),
                        Text(
                          '9,000.00 INR',
                          style: TextStyle(
                            color: text500,
                            fontSize: heading2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          /// tabs for various pages for portfolio
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TabForDashboard(
                  currentTabNumber: _currentTabNumber,
                  label: 'Sell',
                  tabNumber: 0,
                  onPressed: () {
                    setState(() {
                      _currentTabNumber = 0;
                      _scrollController.jumpTo(0);
                    });
                    _pageController.jumpToPage(_currentTabNumber);
                  },
                ),
                const SizedBox(width: 10),
                TabForDashboard(
                  currentTabNumber: _currentTabNumber,
                  label: 'Buy',
                  tabNumber: 1,
                  onPressed: () {
                    setState(() {
                      _currentTabNumber = 1;
                      _scrollController.jumpTo(
                          (_scrollController.position.maxScrollExtent / 3) * 2);
                    });
                    _pageController.jumpToPage(_currentTabNumber);
                  },
                ),
                const SizedBox(width: 10),
                TabForDashboard(
                  currentTabNumber: _currentTabNumber,
                  label: 'Withdraw Orders',
                  tabNumber: 2,
                  onPressed: () {
                    setState(() {
                      _currentTabNumber = 2;
                      _scrollController.jumpTo(
                          ((_scrollController.position.maxScrollExtent + 10) /
                                  3) *
                              3);
                    });
                    _pageController.jumpToPage(_currentTabNumber);
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),

          /// PageView for various screens
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
                  PortfolioSellTransactions(),
                  PortfolioBuyTransactions(),
                  const PortfolioWithdrawTransactions(),
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
