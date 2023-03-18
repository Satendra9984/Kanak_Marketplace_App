import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/screens/withdraw/withdraw_asset_body.dart';
import 'package:tasvat/utils/app_constants.dart';
import 'package:tasvat/screens/buy/views/buy_confirmation.dart';
import 'package:http/http.dart' as http;

class WithdrawAssets extends StatefulWidget {
  const WithdrawAssets({Key? key}) : super(key: key);

  @override
  State<WithdrawAssets> createState() => _WithdrawAssetsState();
}

class _WithdrawAssetsState extends State<WithdrawAssets> {
  Stream<http.Response> _getPriceDataStream() async* {
    // try {
    yield* Stream.periodic(const Duration(seconds: 1), (_) {
      return http.get(
        Uri.parse('https://partners-staging.safegold.com/v1/buy-price'),
        headers: {
          'Authorization': 'Bearer 38778d59d5e17cfadc750e87703eb5e2',
        },
      );
    }).asyncMap((event) async => await event);

    // return http.Response;
    // }catch(e) {
    //
    // }
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
          'Withdraw Assets',
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
            return WithdrawAssetBody(
              goldApiRateData: jsonDecode(response.data!.body),
            );
          },
        ),
      ),
    );
  }
}
