import 'dart:developer';

import 'package:biteblitz/src/core/core.dart';
import 'package:biteblitz/src/models/bankData.dart';
import 'package:biteblitz/src/res/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final AccountRepoProvider = Provider<AccountRepo>((ref) {
  final api = ref.watch(apiProvider);
  return AccountRepo(api: api);
});

class AccountRepo {
  final API _api;

  AccountRepo({required API api}) : _api = api;



  Future<Response?> changePassword({required String OldPassword, required String NewPassword}) async {
    final result =
        await _api.postRequest(url: Endpoints.changePassword, requireAuth: true, body: {"oldpassword": OldPassword, "newpassword": NewPassword});

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}", name: "changePassword/RestaurantRepo");
      return null;
    }, (Response response) {
      return response;
    });
  }

  Future<Response?> deleteAccount({required String password}) async {
    final result = await _api.deleteRequest(url: Endpoints.deleteAccount, requireAuth: true, body: {"password": password});

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}", name: "deleteAccount/RestaurantRepo");
      return null;
    }, (Response response) {
      return response;
    });
  }

  Future<Response?> sendFeedBack({required String message}) async {
    final result = await _api.postRequest(url: Endpoints.addFeedback, requireAuth: true, body: {"feedback": message});

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}", name: "sendFeedback/AccoutREPO");
      return null;
    }, (Response response) {
      return response;
    });
  }

  Future<Response?> contactUS({required String name, required String email, required String message}) async {
    final result = await _api.postRequest(url: Endpoints.contactUS, requireAuth: true, body: {"name": name, "email": email, "message": message});

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}", name: "contactUS/AccoutREPO");
      return null;
    }, (Response response) {
      return response;
    });
  }
}
