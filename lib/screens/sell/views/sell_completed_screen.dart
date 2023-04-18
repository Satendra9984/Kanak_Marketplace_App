import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/services/gold_services.dart';
import '../../../models/BankAccount.dart';
import '../../../models/Transaction.dart';
import '../../../utils/app_constants.dart';
import '../../../widgets/row_details_widget.dart';

class SellCompletedScreen extends ConsumerWidget {
  final ExchangeRates rateData;
  final double amount;
  final bool backToHome;
  const SellCompletedScreen({
    Key? key,
    required this.rateData,
    required this.amount,
    this.backToHome = true,
  }) : super(key: key);

  final double _widgetGap = 10;

  Future<Map<String, dynamic>?> _sellGold(WidgetRef ref) async {
    Map<String, dynamic>? sellInfo;
    try {
      /// GET DEFAULT BANK
      String? dBankId = ref.read(userProvider)?.defaultBankId;
      if (dBankId == null) {
        throw Exception('No Bank Account Available');
      } else {
        List<BankAccount>? bankAccountList =
            ref.read(userProvider)?.bankAccounts;
        if (bankAccountList == null) {
          throw Exception('No Bank Account Available');
        }

        /// SELL GOLD TO AUGMONT AND ADD TO DATABASE
        await GoldServices.sellGold(
          user: ref.read(userProvider)!,
          bankId: dBankId,
          transaction: Transaction(amount: amount),
          rate: rateData,
        ).then((value) {
          if (value != null) {
            sellInfo = value.toJson();
          }
        });
      }
      return sellInfo;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: background,
      ),
      body: FutureBuilder(
        future: _sellGold(ref),
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null || snapshot.hasError) {
            return Center(
              child: Text(
                'Something Went Wrong. Try again',
                style: TextStyle(
                  fontSize: title,
                  color: text500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data!['result']['data'];

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
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
                      '${snapshot.data!['message']}',
                      style: TextStyle(
                        fontSize: heading2,
                        color: text500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ID: ${data['transactionId']}',
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
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
                          SizedBox(height: _widgetGap),
                          const RowDetailWidget(
                              title: 'Transaction Type', value: 'Sell'),
                          SizedBox(height: _widgetGap),
                          RowDetailWidget(
                              title: 'Metal Type',
                              value: '${data['metalType']}'),
                          SizedBox(height: _widgetGap),
                          RowDetailWidget(
                              title: 'Price', value: '${data['rate']} ₹/gm'),
                          SizedBox(height: _widgetGap),
                          RowDetailWidget(
                              title: 'Pre Tax Amount',
                              value: '${data['preTaxAmount']} ₹'),
                          SizedBox(height: _widgetGap),
                          RowDetailWidget(
                              title: 'Total Amount',
                              value: '${data['totalAmount']} ₹'),
                          SizedBox(height: _widgetGap),
                          RowDetailWidget(
                              title: 'Gold Balance',
                              value: '${data['goldBalance']} ₹'),
                          SizedBox(height: _widgetGap),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
                if (backToHome)
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        /// proceed to buy completed SCREEN
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(double.infinity, 50.0),
                        maximumSize: const Size(double.infinity, 60.0),
                        backgroundColor: accentBG,
                      ),
                      child: Text(
                        'Back to Home',
                        style: TextStyle(
                          color: accent2,
                          fontSize: heading2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          } else {
            return Center(
              child: Text(
                'Something Went Wrong',
                style: TextStyle(
                  fontSize: title,
                  color: text500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
