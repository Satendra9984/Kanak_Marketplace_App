import 'package:flutter/material.dart';
import '../utils/app_constants.dart';

class TabForDashboard extends StatelessWidget {
  final String label;
  final int currentTabNumber, tabNumber;
  final Function() onPressed;
  final Color backgroundColor;
  const TabForDashboard({
    Key? key,
    required this.currentTabNumber,
    required this.tabNumber,
    required this.label,
    required this.onPressed,
    this.backgroundColor = const Color(0XFF242424),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 32,
        width: 140,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: currentTabNumber != tabNumber ? backgroundColor : accentBG,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: currentTabNumber == tabNumber ? accent2 : text400,
              fontSize: body2,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
