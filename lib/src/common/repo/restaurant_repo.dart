import 'dart:developer';

import 'package:biteblitz/src/core/core.dart';
import 'package:biteblitz/src/res/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final RestaurantRepoProvider = Provider<RestaurantRepo>((ref) {
  final api = ref.watch(apiProvider);
  return RestaurantRepo(api: api);
});

class RestaurantRepo {
  final API _api;

  RestaurantRepo({required API api}) : _api = api;

  Future<Response?> toggleLive({required bool liveStatus}) async {
    final result = await _api.postRequest(url: Endpoints.toggleLive, requireAuth: true, body: {"live": liveStatus});

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}", name: "toggleLive/RestaurantRepo");
      return null;
    }, (Response response) {
      return response;
    });
  }


}
