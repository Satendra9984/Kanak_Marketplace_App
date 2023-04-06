import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/services/datastore_services.dart';
import 'package:tasvat/services/local_db_services.dart';

class TokenNotifier extends StateNotifier<Token?> {
  TokenNotifier() : super(null);
  late Timer timer;
  Future<void> init() async {
    timer = Timer.periodic( const Duration(minutes: 5), (timer) async {
      await DatastoreServices.getToken().then((token) async {
        if (token == null) {
          return;
        }
        await LocalDBServices.storeGPAccessToken(token.token);
      });
    });
  }

  void close() {
    timer.cancel();
  }
}

final tokenProvider = StateNotifierProvider<TokenNotifier, Token?>(
  (ref) => TokenNotifier()
);