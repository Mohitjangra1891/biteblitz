import 'dart:developer';

import 'package:biteblitz/src/core/core.dart';
import 'package:biteblitz/src/res/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final BankDetailsRepoProvider = Provider<BankDetailsRepo>((ref) {
  final api = ref.watch(apiProvider);
  return BankDetailsRepo(api: api);
});

class BankDetailsRepo {
  final API _api;

  BankDetailsRepo({required API api}) : _api = api;

  Future<Response?> getBankS() async {
    final result = await _api.getRequest(url: Endpoints.getBanks, requireAuth: true);

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}", name: "getBANks/BankDetailsRepo");
      return null;
    }, (Response response) {
      return response;
    });
  }

  Future<Response?> deleteBankAccount({required String id}) async {
    final result = await _api.deleteRequest(url: Endpoints.deleteBankAccount, requireAuth: true, body: {"id": id});

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}", name: "deleteBankAccount/BankDetailsRepo");
      return null;
    }, (Response response) {
      return response;
    });
  }
}
