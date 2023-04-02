import 'package:flutter/cupertino.dart';

import '../utils/app_constants.dart';

class RowDetailWidget extends StatelessWidget {
  const RowDetailWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: text400,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: text500,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
