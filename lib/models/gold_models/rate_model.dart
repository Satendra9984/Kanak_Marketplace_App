class ExchangeRates {
  final String? gBuy;
  final String? gSell;
  final String? sBuy;
  final String? sSell;
  final String? gBuyGst;
  final String? sBuyGst;
  final List<Tax>? taxes;
  final String? blockId;

  ExchangeRates({
    this.gBuy,
    this.gSell,
    this.sBuy,
    this.sSell,
    this.gBuyGst,
    this.sBuyGst,
    this.taxes,
    this.blockId,
  });
  factory ExchangeRates.fromJson(Map<String, dynamic> json) {
    var taxesJson = json['taxes'] as List;
    List<Tax> taxes = taxesJson.map((t) => Tax.fromJson(t)).toList();
    return ExchangeRates(
      gBuy: json['rates']['gBuy'],
      gSell: json['rates']['gSell'],
      sBuy: json['rates']['sBuy'],
      sSell: json['rates']['sSell'],
      gBuyGst: json['rates']['gBuyGst'],
      sBuyGst: json['rates']['sBuyGst'],
      taxes: taxes,
      blockId: json['blockId'],
    );
  }
  ExchangeRates copyWith({
    String? gBuy,
    String? gSell,
    String? sBuy,
    String? sSell,
    String? gBuyGst,
    String? sBuyGst,
    List<Tax>? taxes,
    String? blockId,
  }) {
    return ExchangeRates(
      gBuy: gBuy ?? this.gBuy,
      gSell: gSell ?? this.gSell,
      sBuy: sBuy ?? this.sBuy,
      sSell: sSell ?? this.sSell,
      gBuyGst: gBuyGst ?? this.gBuyGst,
      sBuyGst: sBuyGst ?? this.sBuyGst,
      taxes: taxes ?? this.taxes,
      blockId: blockId ?? this.blockId,
    );
  }
}

class Tax {
  final String type;
  final String taxPerc;

  Tax({
    required this.type,
    required this.taxPerc,
  });

  factory Tax.fromJson(Map<String, dynamic> json) {
    return Tax(
      type: json['type'],
      taxPerc: json['taxPerc'],
    );
  }
}
