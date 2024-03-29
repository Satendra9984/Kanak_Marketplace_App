import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasvat/screens/buy/views/buy_asset_body.dart';
import 'package:tasvat/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class BuyAssets extends StatefulWidget {
  const BuyAssets({Key? key}) : super(key: key);

  @override
  State<BuyAssets> createState() => _BuyAssetsState();
}

class _BuyAssetsState extends State<BuyAssets> {
  Stream<http.Response> _getPriceDataStream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (_) {
      return http.get(
        Uri.parse('https://partners-staging.safegold.com/v1/buy-price'),
        headers: {
          'Authorization': 'Bearer 38778d59d5e17cfadc750e87703eb5e2',
        },
      );
    }).asyncMap((event) async => await event);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.0,
        title: Text(
          'Buy Gold Assets',
          style: TextStyle(
            fontSize: body1,
            color: text500,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: StreamBuilder(
          stream: _getPriceDataStream(),
          builder: (context, AsyncSnapshot<http.Response> response) {
            if (response.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (response.hasError) {
              return const Text('Something went wrong');
            }
            // debugPrint(response.data!.body);
            return BuyAssetBody(
              goldApiRateData: jsonDecode(response.data!.body),
            );
          },
        ),
      ),
    );
  }
}
