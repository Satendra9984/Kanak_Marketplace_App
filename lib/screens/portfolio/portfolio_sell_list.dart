import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/screens/buy/views/buy_completed.dart';
import 'package:tasvat/screens/portfolio/portfolio_sell_info.dart';
import 'package:tasvat/screens/portfolio/transaction_status.dart';
import 'package:tasvat/screens/sell/views/sell_completed_screen.dart';
import 'package:tasvat/screens/withdraw/withdraw_completed.dart';
import 'package:tasvat/services/gold_services.dart';

import '../../utils/app_constants.dart';

class PortfolioSellTransactions extends StatelessWidget {
  PortfolioSellTransactions({super.key});

  final List<Transaction> _transactionList = [
    Transaction(
        id: '123456789',
        type: TransactionType.BUY,
        dateTime: TemporalDateTime.now(),
        amount: 12),
    Transaction(
      id: '123456789',
      type: TransactionType.SELL,
      amount: 5,
      status: TransactionStatus.PENDING,
      dateTime: TemporalDateTime.now(),
    ),
    Transaction(
      id: '123456789',
      type: TransactionType.EXCHANGE,
      amount: 8,
      status: TransactionStatus.PENDING,
      dateTime: TemporalDateTime.now(),
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

  Future<List<Map<String, dynamic>>> getSellList() async {
    List<Map<String, dynamic>> buyList = [];
    await GoldServices.getUserSellList().then((list) {
      buyList = list;
    });
    return buyList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSellList(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: accent2),
          );
        }

        List<Map<String, dynamic>> list = snap.data!;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: text150,
                  child: Icon(
                    Icons.currency_exchange,
                    color: accent1,
                  ),
                ),
                title: Text(
                  'Sell',
                  style: TextStyle(
                    color: text500,
                    fontSize: body1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      list[index]['createdAt'].toString().substring(0, 10),
                      style: TextStyle(
                        color: text300,
                        fontSize: caption,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      list[index]['createdAt'].toString().substring(12, 18),
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
                              list[index]['qty'].toString(),
                              style: TextStyle(
                                color: error,
                                fontSize: heading2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 2.5),
                            Text(
                              'gm',
                              style: TextStyle(
                                color: error,
                                fontSize: caption,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${list[index]['amount']} INR',
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
                        /// ADD IN WITHDRAW ORDER LIST ARROW BUTTON
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (ctx) {
                            return SellInfoScreen(
                                sellMerchantTxnId: list[index]
                                    ['merchantTransactionId']);
                          }),
                        );
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
        );
      },
    );
  }
}
