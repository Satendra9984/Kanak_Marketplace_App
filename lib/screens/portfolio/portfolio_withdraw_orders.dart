import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/screens/portfolio/portfolio_redeem_info.dart';
import 'package:tasvat/screens/portfolio/portfolio_sell_info.dart';
import 'package:tasvat/screens/portfolio/transaction_status.dart';
import 'package:tasvat/screens/sell/views/sell_completed_screen.dart';
import 'package:tasvat/screens/withdraw/withdraw_completed.dart';
import 'package:tasvat/services/gold_services.dart';
import '../../utils/app_constants.dart';

class PortfolioWithdrawTransactions extends StatelessWidget {
  const PortfolioWithdrawTransactions({super.key});

  Future<List<Map<String, dynamic>>> getRedeemList() async {
    List<Map<String, dynamic>> redeemList = [];
    await GoldServices.getUserRedeemList().then((list) {
      redeemList = list;
    });
    return redeemList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRedeemList(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: accent2),
          );
        }

        List<Map<String, dynamic>> list = snap.data!;
        var m = {
          "transactionId": "OD226116025618536050068217",
          "uniqueId": "GE7794778787",
          "merchantOrderId": "bf56a3b7-1b97-4e88-b749-db52bd1e64a5",
          "invoiceNo": null,
          "shippingCharges": "1250.00",
          "modeOfPayment": "Mehul",
          "shippingAddress": {
            "name": "Ravi",
            "mobile": null,
            "address":
                "B 110, 1st Floor, Laxmi Bhavan, Sai Baba nagar, Navghar Road, Bhayandar East",
            "state": "Andaman and Nicobar",
            "city": "North and Middle Andaman",
            "pincode": "401105"
          },
          "awbNo": null,
          "logisticName": null,
          "product": [
            {
              "sku": "AU999GC01R",
              "productName": "Augmont 1Gm Gold Coin (999 Purity)",
              "metalType": "gold",
              "quantity": "3.0000",
              "price": "350.00",
              "amount": "1050.00",
              "productImages": []
            },
            {
              "sku": "BR999S001R",
              "productName": "1 Gm Silver Bar",
              "metalType": "silver",
              "quantity": "2.0000",
              "price": "100.00",
              "amount": "200.00",
              "productImages": []
            }
          ],
          "status": "pending",
          "createdAt": "2020-10-13T04:04:13.000000Z",
          "updatedAt": "2020-10-13T04:04:13.000000Z"
        };
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
                        // TODO: ADD IN WITHDRAW ORDER LIST ARROW BUTTON
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) {
                              return RedeemInfoScreen(
                                  sellMerchantTxnId: list[index]
                                      ['transactionId']);
                            },
                          ),
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

  void _navigateToCompletedScreen(
      BuildContext context, Transaction transactionDetails, String id) {
    if (transactionDetails.type == TransactionType.BUY) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => TransactionStatusScreen(
            buyOrderDetails: transactionDetails,
          ),
        ),
      );
    } else if (transactionDetails.type == TransactionType.SELL) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (ctx) => SellCompletedScreen(
      //       buyOrderDetails: transactionDetails,
      //     ),
      //   ),
      // );
    } else if (transactionDetails.type == TransactionType.EXCHANGE) {
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
