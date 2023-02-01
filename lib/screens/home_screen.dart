import 'package:flutter/material.dart';
import 'package:tasvat/screens/buy/buy_assets.dart';
import 'package:tasvat/screens/dashboard/dashboard.dart';
import 'package:tasvat/screens/portfolio/portfolio_home.dart';
import 'package:tasvat/screens/sell/sell_assets.dart';
import 'package:tasvat/screens/withdraw/withdraw_assets.dart';
import 'package:tasvat/utils/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0XFF141414),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          DashboardScreen(),
          PortfolioHome()
        ],
        onPageChanged: (int index) {},
      ),
      floatingActionButton: Container(
        // alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: text150,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              heroTag: '0',
              elevation: 5.0,
              backgroundColor:
                  _currentSelectedBottomNavItem == 0 ? accent2 : text150,
              onPressed: () {
                setState(() {
                  _currentSelectedBottomNavItem = 0;
                  _pageController.jumpToPage(0);
                });
              },
              child: Icon(
                Icons.home_filled,
                size: 24,
                color:
                    _currentSelectedBottomNavItem == 0 ? background : text400,
              ),
            ),
            const SizedBox(width: 15),
            FloatingActionButton.small(
              heroTag: '1',
              elevation: 5.0,
              backgroundColor:
                  _currentSelectedBottomNavItem == 1 ? accent2 : text150,
              onPressed: () async {
                setState(() {
                  _currentSelectedBottomNavItem = 1;
                });
                await _showBottomSheet();
              },
              child: Icon(
                Icons.swap_vert_outlined,
                size: 24,
                color:
                    _currentSelectedBottomNavItem == 1 ? background : text400,
              ),
            ),
            const SizedBox(width: 15),
            FloatingActionButton.small(
              heroTag: '2',
              elevation: 5.0,
              backgroundColor:
                  _currentSelectedBottomNavItem == 2 ? accent2 : text150,
              onPressed: () {
                setState(() {
                  _currentSelectedBottomNavItem = 2;
                  _pageController.jumpToPage(1);
                });
              },
              child: Icon(
                Icons.grid_view_rounded,
                size: 24,
                color:
                    _currentSelectedBottomNavItem == 2 ? background : text400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
            color: text100,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trade',
                      style: TextStyle(
                        color: text300,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // remove this modalBottomSheet
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.clear,
                        color: text400,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),

              /// buy
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BuyAssets(),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: accentBG,
                  child: Icon(
                    Icons.add_rounded,
                    color: accent1,
                    size: 32,
                  ),
                ),
                title: Text(
                  'Buy',
                  style: TextStyle(
                    color: text500,
                    fontSize: heading2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Buy gold with cash in wallet',
                  style: TextStyle(
                    color: text300,
                    fontSize: body2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              /// sell
              ListTile(
                onTap: () {
                  // TODO : sell GOLD
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => SellAssets(),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: accentBG,
                  child: Icon(
                    Icons.currency_exchange,
                    color: accent1,
                  ),
                ),
                title: Text(
                  'Sell',
                  style: TextStyle(
                    color: text500,
                    fontSize: heading2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Sell gold for cash',
                  style: TextStyle(
                    color: text300,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// withdraw
              ListTile(
                onTap: () {
                  // TODO : WITHDRAW GOLD
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => WithdrawAssets(),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: accentBG,
                  child: Icon(
                    Icons.file_download_outlined,
                    color: accent1,
                  ),
                ),
                title: Text(
                  'Withdraw',
                  style: TextStyle(
                    color: text500,
                    fontSize: heading2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Receive physical gold in store',
                  style: TextStyle(
                    color: text300,
                    fontSize: body2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
