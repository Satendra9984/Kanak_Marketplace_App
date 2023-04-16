import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasvat/services/gold_services.dart';
import '../../../models/Transaction.dart';
import '../../../models/TransactionStatus.dart';
import '../../../utils/app_constants.dart';
import '../../../widgets/row_details_widget.dart';

class BuyInfoScreen extends StatelessWidget {
  final String buyMerchantTxnId;
  const BuyInfoScreen({
    Key? key,
    required this.buyMerchantTxnId,
  }) : super(key: key);

  final double _rowWidgetsGap = 20;
  Future<Map<String, dynamic>> getBuyInfo() async {
    Map<String, dynamic> buyInfo = {};

    // await GoldServices.getBuyInfo(buyTxnId: buyMerchantTxnId).then((value) {
    //   buyInfo = value;
    // });

    return buyInfo;
  }

  Widget getTopWidget(dynamic isCancelled) {
    if (isCancelled != null && isCancelled == 'Yes') {
      return Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: darkGreen,
            child: Icon(
              Icons.warning,
              size: 32,
              color: error,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Buy Cancelled',
            style: TextStyle(
              fontSize: title,
              color: text500,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: darkGreen,
          child: Icon(
            FontAwesomeIcons.check,
            size: 32,
            color: success,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Buy Completed',
          style: TextStyle(
            fontSize: title,
            color: text500,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: background,
      ),
      body: FutureBuilder(
        future: getBuyInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: accent2),
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Something Went Wrong\nNo Data Found'),
            );
          }
          Map<String, dynamic> buyInfo = snapshot.data!;
          buyInfo = {
            "quantity": "20.0000",
            "totalAmount": "107573.20",
            "preTaxAmount": "104440.00",
            "rate": "5222.00",
            "uniqueId": "GE7794778787",
            "transactionId": "MD755616025611553150068217",
            "userName": "Ravi Ramswaroop",
            "mobileNumber": "7794778787",
            "goldBalanceInGM": "20.0000",
            "silverBalanceInGM": "20.2000",
            "IsCancelled": "No",
            "taxes": {
              "totalTaxAmount": "3133.20",
              "taxSplit": [
                {"type": "CGST", "taxPerc": "1.50", "taxAmount": "1566.60"},
                {"type": "SGST", "taxPerc": "1.50", "taxAmount": "1566.60"},
                {"type": "IGST", "taxPerc": "0.00", "taxAmount": "0.00"}
              ]
            },
            "invoiceNumber": "GMD102112",
            "updatedAt": "2020-10-13 09:22:35"
          };
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              getTopWidget(buyInfo['IsCancelled']),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ID: ${buyInfo['transactionId']}',
                    style: TextStyle(
                      color: text300,
                      fontSize: body1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //TODO: COPY TO CLIPBOARD
                    },
                    icon: Icon(
                      Icons.copy,
                      size: 18,
                      color: accent1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// Identification
              Container(
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  color: text100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Identification',
                      style: TextStyle(
                        color: text300,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: _rowWidgetsGap),
                    RowDetailWidget(
                        title: 'Quantity', value: '${buyInfo['quantity']} gm'),
                    SizedBox(height: _rowWidgetsGap),
                    RowDetailWidget(
                        title: 'Rate', value: '${buyInfo['rate']} ₹/gm'),
                    SizedBox(height: _rowWidgetsGap),

                    RowDetailWidget(
                        title: 'Pre Tax Amount',
                        value: '${buyInfo['preTaxAmount']} ₹'),
                    SizedBox(height: _rowWidgetsGap),

                    /// Taxes
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: buyInfo['taxes']['taxSplit'].length,
                      itemBuilder: (context, index) {
                        return RowDetailWidget(
                            title: buyInfo['taxes']['taxSplit'][index]['type'],
                            value:
                                '${buyInfo['taxes']['taxSplit'][index]['taxAmount']} ₹');
                      },
                    ),

                    SizedBox(height: _rowWidgetsGap),
                    RowDetailWidget(
                        title: 'Final Amount',
                        value: '${buyInfo['totalAmount']} ₹'),
                    SizedBox(height: _rowWidgetsGap),
                    RowDetailWidget(
                        title: 'Total Gold Balance',
                        value: '${buyInfo['goldBalanceInGM']} gm'),
                    SizedBox(height: _rowWidgetsGap),
                    RowDetailWidget(
                        title: 'Invoice Number',
                        value: '${buyInfo['invoiceNumber']}'),
                    SizedBox(height: _rowWidgetsGap),
                    RowDetailWidget(
                        title: 'Updated', value: '${buyInfo['updatedAt']}'),
                  ],
                ),
              ),
              // const SizedBox(height: 5),
              //
              // /// Total
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: 15, vertical: 20),
              //   margin: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     color: text100,
              //     borderRadius: BorderRadius.circular(15),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Total',
              //         style: TextStyle(
              //             color: text300,
              //             fontSize: body2,
              //             fontWeight: FontWeight.w600),
              //       ),
              //       const SizedBox(height: 25),
              //       RowDetailWidget(
              //           title: 'Equal',
              //           value: '${transaction.amount! * 100000} INR'),
              //       const SizedBox(height: 25),
              //       const RowDetailWidget(
              //           title: 'Method', value: 'Cash Wallet'),
              //     ],
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
