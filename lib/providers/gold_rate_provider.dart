import 'package:amplify_core/amplify_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/models/gold_models/rate_model.dart';
import 'package:tasvat/services/gold_services.dart';

class GoldRateNotifier extends StateNotifier<ExchangeRates> {
  GoldRateNotifier() : super(ExchangeRates());

  Future<void> updateRates() async {
    await GoldServices.getMetalsRate().then((rates) {
      if (rates == null) {
        return;
      }
      safePrint(rates);
      state = rates;
    });
  }
}

final goldRateProvider = StateNotifierProvider<GoldRateNotifier, ExchangeRates>(
    (ref) => GoldRateNotifier());
