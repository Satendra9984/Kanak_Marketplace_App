import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tasvat/models/transaction_model.dart';
import 'package:tasvat/screens/buy/buy_completed.dart';

import '../../app_constants.dart';
import '../../models/withdraw_orders_model.dart';
import '../sell/sell_completed_screen.dart';
import '../withdraw/book_completed.dart';
import '../withdraw/withdraw_completed.dart';

class PortfolioTransactions extends StatelessWidget {
  PortfolioTransactions({super.key});

  final List<Transaction> _transactionList = [
    Transaction(
        activityName: 'Buy',
        quantity: 1.0,
        date: '15/06/2021',
        time: '18:30',
        price: 300.00),
    Transaction(
        activityName: 'Sell',
        quantity: -1.0,
        date: '15/06/2021',
        time: '18:30',
        price: 300.00),
    Transaction(
        activityName: 'Withdraw',
        quantity: 1.0,
        date: '15/06/2021',
        time: '18:30',
        price: 300.00),
  ];

  IconData _getIcon(int index) {
    if (_transactionList[index].activityName == 'Buy') {
      return Icons.add;
    } else if (_transactionList[index].activityName == 'Sell') {
      return Icons.currency_exchange;
    }

    return Icons.file_download_outlined;
  }

  Color _getPriceColor(int index) {
    if (_transactionList[index].activityName == 'Buy') {
      return success;
    } else if (_transactionList[index].activityName == 'Sell') {
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
                  _transactionList[index].activityName,
                  style: TextStyle(
                    color: text500,
                    fontSize: body1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      _transactionList[index].date,
                      style: TextStyle(
                        color: text300,
                        fontSize: caption,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _transactionList[index].time,
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
                              _transactionList[index].quantity.toString(),
                              style: TextStyle(
                                color: _getPriceColor(index),
                                fontSize: heading2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 2.5),
                            Text(
                              'mace',
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
                          '${_transactionList[index].price} USD',
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
    if (transactionDetails.activityName == 'Buy') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => BuyCompletedScreen(
            buyOrderDetails: transactionDetails,
            id: id,
          ),
        ),
      );
    } else if (transactionDetails.activityName == 'Sell') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => SellCompletedScreen(
            buyOrderDetails: transactionDetails,
            id: id,
          ),
        ),
      );
    } else if (transactionDetails.activityName == 'Withdraw') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => WithdrawCompletedScreen(
            buyOrderDetails: transactionDetails,
            id: id,
          ),
        ),
      );
    }
  }
}
