import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasvat/services/gold_services.dart';
import '../../../models/Transaction.dart';
import '../../../models/TransactionStatus.dart';
import '../../../utils/app_constants.dart';
import '../../../widgets/row_details_widget.dart';

class RedeemInfoScreen extends StatelessWidget {
  final String sellMerchantTxnId;
  const RedeemInfoScreen({
    Key? key,
    required this.sellMerchantTxnId,
  }) : super(key: key);

  final double _rowWidgetsGap = 10;
  Future<Map<String, dynamic>> getRedeemInfo() async {
    Map<String, dynamic> sellInfo = {};

    await GoldServices.getRedeemInfo(sellTxnId: sellMerchantTxnId)
        .then((value) {
      sellInfo = value;
    });

    return sellInfo;
  }

  Widget getTopWidget(dynamic status) {
    if (status != null && status == 'Pending') {
      return Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: darkGreen,
            child: Icon(
              Icons.watch_later_outlined,
              size: 32,
              color: warning,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Pending',
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
          'Redemption Completed',
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
        future: getRedeemInfo(),
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
          Map<String, dynamic> redeemInfo = snapshot.data!;
          redeemInfo = {
            "transactionId": "OD100816025620760150068217",
            "uniqueId": "GE7794778787",
            "merchantOrderId": "9f5c3dd5-17b1-4024-bc56-94af08a39ebd",
            "invoiceNo": null,
            "shippingCharges": "650.00",
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
            "productDetails": [
              {
                "sku": "AU999GC01R",
                "productName": "Augmont 1Gm Gold Coin (999 Purity)",
                "metalType": "gold",
                "quantity": "1.0000",
                "price": "350.00",
                "amount": "350.00",
                "productImages": []
              },
              {
                "sku": "AU999GC005R",
                "productName": "Augmont 0.5Gm Gold Coin (999 Purity)",
                "metalType": "gold",
                "quantity": "1.0000",
                "price": "300.00",
                "amount": "300.00",
                "productImages": [
                  {
                    "url":
                        "https://uat-augmontgold.s3.ap-south-1.amazonaws.com/products/7/gallery/b5d5c3ddb9bf39fcabaa8cb3213f75b6.png",
                    "displayOrder": 3,
                    "defaultImage": true
                  }
                ]
              }
            ],
            "status": "Pending",
            "createdAt": "2020-10-13T04:07:56.000000Z",
            "updatedAt": "2020-10-13T04:07:56.000000Z"
          };
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                getTopWidget(redeemInfo['status']),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ID: ${redeemInfo['transactionId']}',
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
                      SizedBox(height: _rowWidgetsGap + 8),
                      RowDetailWidget(
                          title: 'Status', value: '${redeemInfo['status']}'),
                      SizedBox(height: _rowWidgetsGap),
                      RowDetailWidget(
                          title: 'Invoice',
                          value: '${redeemInfo['invoiceNo']}'),
                      SizedBox(height: _rowWidgetsGap),
                      RowDetailWidget(
                          title: 'Mode of Payment',
                          value: '${redeemInfo['modeOfPayment']}'),
                      SizedBox(height: _rowWidgetsGap),
                    ],
                  ),
                ),

                /// Products
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
                        'Products',
                        style: TextStyle(
                          color: text300,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: _rowWidgetsGap + 8),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: redeemInfo['productDetails'].length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Image.network(
                                "https://uat-augmontgold.s3.ap-south-1.amazonaws.com/products/7/gallery/b5d5c3ddb9bf39fcabaa8cb3213f75b6.png",
                                height: 64,
                                width: 64,
                                fit: BoxFit.cover,
                              ),
                              RowDetailWidget(
                                  title: 'SKU',
                                  value:
                                      '${redeemInfo['productDetails'][index]['sku']}'),
                              const SizedBox(height: 5),
                              RowDetailWidget(
                                  title: 'Product',
                                  value:
                                      '${redeemInfo['productDetails'][index]['productName']}'),
                              const SizedBox(height: 5),
                              RowDetailWidget(
                                  title: 'Metal Type',
                                  value:
                                      '${redeemInfo['productDetails'][index]['metalType']}'),
                              const SizedBox(height: 5),
                              RowDetailWidget(
                                  title: 'Quantity',
                                  value:
                                      '${redeemInfo['productDetails'][index]['quantity']}'),
                              const SizedBox(height: 5),
                              RowDetailWidget(
                                  title: 'Price',
                                  value:
                                      '${redeemInfo['productDetails'][index]['price']}'),
                              const SizedBox(height: 5),
                              RowDetailWidget(
                                  title: 'Amount',
                                  value:
                                      '${redeemInfo['productDetails'][index]['amount']}'),
                              SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: _rowWidgetsGap),
                    ],
                  ),
                ),

                /// Shipping Address
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
                        'Shipping Address',
                        style: TextStyle(
                          color: text300,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: _rowWidgetsGap + 8),
                      RowDetailWidget(
                          title: 'Name',
                          value: '${redeemInfo['shippingAddress']['name']}'),
                      SizedBox(height: _rowWidgetsGap),
                      RowDetailWidget(
                          title: 'mobile',
                          value: '${redeemInfo['shippingAddress']['mobile']}'),
                      SizedBox(height: _rowWidgetsGap),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address',
                            style: TextStyle(
                              color: text400,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2.5),
                          Text(
                            '${redeemInfo['shippingAddress']['address']}',
                            style: TextStyle(
                              color: text500,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: _rowWidgetsGap),
                      RowDetailWidget(
                          title: 'State',
                          value: '${redeemInfo['shippingAddress']['state']}'),
                      SizedBox(height: _rowWidgetsGap),
                      RowDetailWidget(
                          title: 'City',
                          value: '${redeemInfo['shippingAddress']['city']}'),
                      SizedBox(height: _rowWidgetsGap),
                      RowDetailWidget(
                          title: 'Pincode',
                          value: '${redeemInfo['shippingAddress']['pincode']}'),
                      SizedBox(height: _rowWidgetsGap),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
