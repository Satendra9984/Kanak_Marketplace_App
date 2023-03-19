class BuyInfo {
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
  Taxes taxes;
  String invoiceNumber;

  BuyInfo({
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
    required this.taxes,
    required this.invoiceNumber,
  });

  factory BuyInfo.fromJson(Map<String, dynamic> json) {
    return BuyInfo(
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
      taxes: Taxes.fromJson(json['taxes']),
      invoiceNumber: json['invoiceNumber'],
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
    data['taxes'] = taxes.toJson();
    data['invoiceNumber'] = invoiceNumber;
    return data;
  }
}

class Taxes {
  String totalTaxAmount;
  List<TaxSplit> taxSplit;

  Taxes({required this.totalTaxAmount, required this.taxSplit});

  factory Taxes.fromJson(Map<String, dynamic> json) {
    var list = json['taxSplit'] as List;
    List<TaxSplit> taxSplitList =
        list.map((i) => TaxSplit.fromJson(i)).toList();
    return Taxes(
      totalTaxAmount: json['totalTaxAmount'],
      taxSplit: taxSplitList
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalTaxAmount'] = totalTaxAmount;
    data['taxSplit'] = taxSplit.map((v) => v.toJson()).toList();
    return data;
  }
}

class TaxSplit {
  String type;
  String taxPerc;
  String taxAmount;

  TaxSplit({
    required this.type,
    required this.taxPerc,
    required this.taxAmount,
  });

  factory TaxSplit.fromJson(Map<String, dynamic> json) {
    return TaxSplit(
      type: json['type'],
      taxPerc: json['taxPerc'],
      taxAmount: json['taxAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['taxPerc'] = taxPerc;
    data['taxAmount'] = taxAmount;
    return data;
  }
}