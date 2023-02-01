import 'package:flutter/material.dart';
import 'package:tasvat/utils/app_constants.dart';
import 'package:tasvat/models/assets_model.dart';

class PortfolioAssets extends StatelessWidget {
  PortfolioAssets({super.key});

  final List<AssetsModel> _list = [
    AssetsModel(quantity: 10, assetType: 'Gold Asset', quantityType: 0.5),
    AssetsModel(quantity: 10, assetType: 'Gold Asset', quantityType: 1.0),
    AssetsModel(quantity: 5, assetType: 'Gold Asset', quantityType: 2.0),
    AssetsModel(quantity: 1, assetType: 'Gold Asset', quantityType: 5.0),
  ];

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
                  backgroundColor: Colors.grey.shade800,
                  child: Icon(
                    Icons.star,
                    color: accent2,
                  ),
                ),
                title: Text(
                  _list[index].assetType,
                  style: TextStyle(
                    color: text400,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  '${_list[index].quantityType}-Maced Piece',
                  style: TextStyle(
                    color: text500,
                    fontSize: body1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Quantity',
                      style: TextStyle(
                        color: text300,
                        fontSize: body2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _list[index].quantity.toString(),
                      style: TextStyle(
                        color: text500,
                        fontSize: body1,
                        fontWeight: FontWeight.w500,
                      ),
                    )
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
