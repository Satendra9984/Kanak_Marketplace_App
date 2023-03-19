class SellInfo {
  String quantity;
  String totalAmount;
  String preTaxAmount;
  String metalType;
  String rate;
  String uniqueId;
  String transactionId;
  String userName;
  String merchantTransactionId;
  String mobileNumber;
  String goldBalance;
  String silverBalance;

  SellInfo({
    required this.quantity,
    required this.totalAmount,
    required this.preTaxAmount,
    required this.metalType,
    required this.rate,
    required this.uniqueId,
    required this.transactionId,
    required this.userName,
    required this.merchantTransactionId,
    required this.mobileNumber,
    required this.goldBalance,
    required this.silverBalance,
  });

  factory SellInfo.fromJson(Map<String, dynamic> json) {
    return SellInfo(
      quantity: json['quantity'],
      totalAmount: json['totalAmount'],
      preTaxAmount: json['preTaxAmount'],
      metalType: json['metalType'],
      rate: json['rate'],
      uniqueId: json['uniqueId'],
      transactionId: json['transactionId'],
      userName: json['userName'],
      merchantTransactionId: json['merchantTransactionId'],
      mobileNumber: json['mobileNumber'],
      goldBalance: json['goldBalance'],
      silverBalance: json['silverBalance'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['totalAmount'] = totalAmount;
    data['preTaxAmount'] = preTaxAmount;
    data['metalType'] = metalType;
    data['rate'] = rate;
    data['uniqueId'] = uniqueId;
    data['transactionId'] = transactionId;
    data['userName'] = userName;
    data['merchantTransactionId'] = merchantTransactionId;
    data['mobileNumber'] = mobileNumber;
    data['goldBalance'] = goldBalance;
    data['silverBalance'] = silverBalance;
    return data;
  }
}
