import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/Transaction.dart';

class AddMoneyStatusScreen extends ConsumerWidget {
  final Transaction transaction;

  const AddMoneyStatusScreen({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint(transaction.toMap().toString());

    return Container();
  }
}
