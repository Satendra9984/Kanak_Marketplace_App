class UserBank {
  String userBankId;
  String uniqueId;
  dynamic bankId;
  dynamic bankName;
  String accountNumber;
  String accountName;
  String ifscCode;
  String status;

  UserBank({
    required this.userBankId,
    required this.uniqueId,
    this.bankId,
    this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.ifscCode,
    required this.status,
  });

  factory UserBank.fromJson(Map<String, dynamic> json) {
    return UserBank(
      userBankId: json['userBankId'],
      uniqueId: json['uniqueId'],
      bankId: json['bankId'],
      bankName: json['bankName'],
      accountNumber: json['accountNumber'],
      accountName: json['accountName'],
      ifscCode: json['ifscCode'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userBankId'] = userBankId;
    data['uniqueId'] = uniqueId;
    data['bankId'] = bankId;
    data['bankName'] = bankName;
    data['accountNumber'] = accountNumber;
    data['accountName'] = accountName;
    data['ifscCode'] = ifscCode;
    data['status'] = status;
    return data;
  }
}
