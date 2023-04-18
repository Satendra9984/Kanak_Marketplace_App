import 'package:amplify_flutter/amplify_flutter.dart';

class UserBank {
  String userBankId;
  String uniqueId;
  String accountNumber;
  String accountName;
  String ifscCode;
  String? status;

  UserBank({
    required this.userBankId,
    required this.uniqueId,
    required this.accountNumber,
    required this.accountName,
    required this.ifscCode,
    this.status,
  });

  factory UserBank.fromJson(Map<String, dynamic> json) {
    safePrint(json);
    return UserBank(
      userBankId: json['userBankId'],
      uniqueId: json['uniqueId'],
      accountNumber: json['accountNumber'].toString(),
      accountName: json['accountName'],
      ifscCode: json['ifscCode'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userBankId'] = userBankId;
    data['uniqueId'] = uniqueId;
    data['accountNumber'] = accountNumber;
    data['accountName'] = accountName;
    data['ifscCode'] = ifscCode;
    data['status'] = status;
    return data;
  }
}
