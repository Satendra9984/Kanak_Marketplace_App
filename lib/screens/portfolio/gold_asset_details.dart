import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_constants.dart';

class GoldAssetDetailsScreen extends StatelessWidget {
  const GoldAssetDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.0,
        title: const Text('Gold Asset Details'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: text100,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: '30',
                    style: TextStyle(
                      color: accent1,
                      fontSize: title + 5,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: '\tgm',
                        style: TextStyle(
                          color: text400,
                          fontSize: body1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Invested',
                          style: TextStyle(
                            color: text400,
                            fontSize: body2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹ 5000 ',
                          style: TextStyle(
                            color: text500,
                            fontSize: heading1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Current',
                          style: TextStyle(
                            color: text400,
                            fontSize: body2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹ 5200 ',
                          style: TextStyle(
                            color: text500,
                            fontSize: heading1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'P&L',
                      style: TextStyle(
                        color: text500,
                        fontSize: body1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '+ ₹200 ',
                      style: TextStyle(
                        color: text500,
                        fontSize: body1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '10%',
                      style: TextStyle(
                        color: text500,
                        fontSize: body1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
