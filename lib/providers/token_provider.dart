import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/services/datastore_services.dart';
import 'package:tasvat/services/local_db_services.dart';

class TokenNotifier extends StateNotifier<Token?> {
  TokenNotifier() : super(null);
  late Timer timer;
  Future<void> init() async {
    await DatastoreServices.getToken().then((value) async {
      if (value != null) {
        await LocalDBServices.storeGPAccessToken(value.token);
      }
    });
    timer = Timer.periodic( const Duration(minutes: 5), (timer) async {
      await DatastoreServices.getToken().then((token) async {
        safePrint(token?.token);
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