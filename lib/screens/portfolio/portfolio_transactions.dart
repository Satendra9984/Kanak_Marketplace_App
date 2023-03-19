import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/screens/buy/views/buy_completed.dart';
import 'package:tasvat/screens/sell/sell_completed_screen.dart';
import 'package:tasvat/screens/withdraw/withdraw_completed.dart';

import '../../utils/app_constants.dart';

class PortfolioTransactions extends StatelessWidget {
  PortfolioTransactions({super.key});

  final List<Transaction> _transactionList = [
    Transaction(
        id: '123456789',
        type: TransactionType.BUY,
        dateTime: TemporalDateTime.fromString('2023-03-05'),
        amount: 12),
    Transaction(
        id: '123456789',
        type: TransactionType.SELL,
        amount: 5,
        status: TransactionStatus.PENDING,
        dateTime: TemporalDateTime.fromString('2023-03-05')),
    Transaction(
      id: '123456789',
      type: TransactionType.EXCHANGE,
      amount: 8,
      status: TransactionStatus.PENDING,
      dateTime: TemporalDateTime.fromString('2023-03-05'),
    ),
  ];

  IconData _getIcon(int index) {
    if (_transactionList[index].type == TransactionType.BUY) {
      return Icons.add;
    } else if (_transactionList[index].type == TransactionType.SELL) {
      return Icons.currency_exchange;
    }
    return Icons.file_download_outlined;
  }

  Color _getPriceColor(int index) {
    if (_transactionList[index].type == TransactionType.BUY) {
      return success;
    } else if (_transactionList[index].type == TransactionType.SELL) {
      return error;
    }

    return information;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: _transactionList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: text150,
                  child: Icon(
                    _getIcon(index),
                    color: accent1,
                  ),
                ),
                title: Text(
                  _transactionList[index].type.toString(),
                  style: TextStyle(
                    color: text500,
                    fontSize: body1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      _transactionList[index]
                          .dateTime
                          .toString()
                          .substring(0, 10),
                      style: TextStyle(
                        color: text300,
                        fontSize: caption,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _transactionList[index]
                          .dateTime
                          .toString()
                          .substring(0, 10),
                      style: TextStyle(
                        color: text300,
                        fontSize: caption,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _transactionList[index].amount.toString(),
                              style: TextStyle(
                                color: _getPriceColor(index),
                                fontSize: heading2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 2.5),
                            Text(
                              'gm',
                              style: TextStyle(
                                color: _getPriceColor(index),
                                fontSize: caption,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${10000} INR',
                          style: TextStyle(
                            color: text300,
                            fontSize: body2,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: ADD IN WITHDRAW ORDER LIST ARROW BUTTON
                        _navigateToCompletedScreen(
                            context, _transactionList[index], index.toString());
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: text300,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _navigateToCompletedScreen(
      BuildContext context, Transaction transactionDetails, String id) {
    if (transactionDetails.type == 'Buy') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => BuyCompletedScreen(
            buyOrderDetails: transactionDetails,
          ),
        ),
      );
    } else if (transactionDetails.type == 'Sell') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => SellCompletedScreen(
            buyOrderDetails: transactionDetails,
          ),
        ),
      );
    } else if (transactionDetails.type == 'Withdraw') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => WithdrawCompletedScreen(
            buyOrderDetails: transactionDetails,
          ),
        ),
      );
    }
  }
}
