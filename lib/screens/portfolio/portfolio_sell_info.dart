import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasvat/services/gold_services.dart';
import '../../../models/Transaction.dart';
import '../../../models/TransactionStatus.dart';
import '../../../utils/app_constants.dart';
import '../../../widgets/row_details_widget.dart';

class SellInfoScreen extends StatelessWidget {
  final String sellMerchantTxnId;
  const SellInfoScreen({
    Key? key,
    required this.sellMerchantTxnId,
  }) : super(key: key);

  final double _rowWidgetsGap = 20;
  Future<Map<String, dynamic>> getSellInfo() async {
    Map<String, dynamic> sellInfo = {};

    // await GoldServices.getSellInfo(sellTxnId: sellMerchantTxnId).then((value) {
    //   sellInfo = value;
    // });

    return sellInfo;
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
            'Sell Cancelled',
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
          'Sell Completed',
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
        future: getSellInfo(),
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
          Map<String, dynamic> sellInfo = snapshot.data!;
          sellInfo = {
            "quantity": "0.1000",
            "totalAmount": "6.82",
            "preTaxAmount": "6.82",
            "metalType": "silver",
            "rate": "0.00",
            "uniqueId": "UNIQUEID006543",
            "transactionId": "MB11501598872681361",
            "userName": "D'souza",
            "merchantTransactionId": "6df4b1bc-b8c7-4fa9-8efa-686b7ffb4ef3",
            "mobileNumber": "9321157769",
            "goldBalance": "28.0000",
            "silverBalance": "46.4000",
            "IsCancelled": "No"
          };
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              getTopWidget(sellInfo['IsCancelled']),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ID: ${sellInfo['transactionId']}',
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
                        title: 'Metal', value: '${sellInfo['metalType']}'),
                    SizedBox(height: _rowWidgetsGap),
                    RowDetailWidget(
                        title: 'Quantity', value: '${sellInfo['quantity']} gm'),
                    SizedBox(height: _rowWidgetsGap),
                    RowDetailWidget(
                        title: 'Rate', value: '${sellInfo['rate']} ₹/gm'),
                    SizedBox(height: _rowWidgetsGap),
                    RowDetailWidget(
                        title: 'Pre Tax Amount',
                        value: '${sellInfo['preTaxAmount']} ₹'),
                    SizedBox(height: _rowWidgetsGap),
                    RowDetailWidget(
                        title: 'Total Amount',
                        value: '${sellInfo['totalAmount']} ₹'),
                    SizedBox(height: _rowWidgetsGap),
                    SizedBox(height: _rowWidgetsGap),
                    RowDetailWidget(
                        title: 'Total Gold Balance',
                        value: '${sellInfo['goldBalance']} gm'),
                    SizedBox(height: _rowWidgetsGap),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
