
import 'package:flutter/material.dart';
import 'package:tasvat/utils/app_constants.dart';
import '../../models/withdraw_orders_model.dart';

class PortfolioWithdrawOrders extends StatelessWidget {
  PortfolioWithdrawOrders({super.key});

  final List<WithdrawOrdersModel> _list = [
    WithdrawOrdersModel(
        status: 'Processing', dateTime: '15/06/2021', quantity: -1.0),
    WithdrawOrdersModel(
        status: 'Completed', dateTime: '15/06/2021', quantity: -1.0),
    WithdrawOrdersModel(
        status: 'Completed', dateTime: '15/06/2021', quantity: -1.0),
  ];

  Color _getStatusColor(int index) {
    if (_list[index].status == 'Processing') {
      return warning;
    } else if (_list[index].status == 'Completed') {
      return success;
    } else if (_list[index].status == 'Processing') {
      return error;
    }
    return error;
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
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: text150,
                  child: Icon(
                    Icons.file_download_outlined,
                    color: accent1,
                  ),
                ),
                title: Text(
                  'Withdraw',
                  style: TextStyle(
                    color: text500,
                    fontSize: body1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  _list[index].status,
                  style: TextStyle(
                    color: _getStatusColor(index),
                    fontSize: caption,
                    fontWeight: FontWeight.w500,
                  ),
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
                              _list[index].quantity.toString(),
                              style: TextStyle(
                                color: text500,
                                fontSize: heading2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 2.5),
                            Text(
                              'mace',
                              style: TextStyle(
                                color: text400,
                                fontSize: caption,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _list[index].dateTime,
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
}
