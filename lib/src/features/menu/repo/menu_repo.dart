import 'dart:developer';

import 'package:biteblitz/src/core/core.dart';
import 'package:biteblitz/src/res/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final menuRepoProvider = Provider<MenuRepo>((ref) {
  final api = ref.watch(apiProvider);
  return MenuRepo(api: api);
});

class MenuRepo {
  final API _api;

  MenuRepo({required API api}) : _api = api;

  Future<Response?> getAllMenuItems() async {
    final result = await _api.getRequest(url: Endpoints.login, requireAuth: true);

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}", name: "getAllMenu/MenuRepo");
      return null;
    }, (Response response) {
      return response;
    });
  }

  Future<Response?> addNewMenuItem(
      {required String name, required int price, required String category, required String image, required bool isVeg}) async {
    final result = await _api.postRequest(url: Endpoints.addNewMenuItem, requireAuth: true, body: {
      "name": name,
      "price": price,
      "category": category,
      "image": image,
      "veg": isVeg
    });

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}");
      return null;
    }, (Response response) {
      return response;
    });
  }
}
