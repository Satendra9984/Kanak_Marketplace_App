import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/utils/app_constants.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.0,
        title: Text('Account details'),
      ),
      body: Column(),
    );
  }
}
