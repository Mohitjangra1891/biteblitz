import 'dart:developer';

import 'package:biteblitz/src/core/core.dart';
import 'package:biteblitz/src/res/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final authRepoProvider = Provider<AuthRepo>((ref) {
  final api = ref.watch(apiProvider);
  return AuthRepo(api: api);
});

class AuthRepo {
  final API _api;

  AuthRepo({required API api}) : _api = api;

  Future<Response?> login({required String email, required String password}) async {
    final result = await _api.postRequest(url: Endpoints.login, requireAuth: false, body: {
      'email': email,
      'password': password,
    });

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}", name: "login/AUTHREPO");
      return null;
    }, (Response response) {
      // log("SUCCESS - statusCode :  ${response.statusCode} \n", name: "login/AUTHREPO");

      return response;
    });
  }

  Future<Response?> register({required dynamic body}) async {
    final result = await _api.postRequest(url: Endpoints.register, requireAuth: false, body: body);

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}", name: "REGISTER/AUTHREPO");
      return null;
    }, (Response response) {
      // log("SUCCESS - statusCode :  ${response.statusCode} \n", name: "REGISTER/AUTHREPO");

      return response;
    });
  }

  // Future<Response?> verifyOtp({required String number, required String otp}) async {
  //   final result = await _api.postRequest(url: Endpoints.verifyOtp, requireAuth: false, body: {
  //     'phonenumber': number,
  //     'otp': otp,
  //   });
  //
  //   return result.fold((Failure failure) {
  //     log("Failed to fetch - ${failure.message}");
  //     return null;
  //   }, (Response response) {
  //     // log("SUCCESS - statusCode :  ${response.statusCode} \n", name: "VERIFYOTP/AUTHREPO");
  //
  //     return response;
  //   });
  // }

  Future<Response?> add_PanCard_details({required String panNumber, required String panName, required String imageUrl}) async {
    final result = await _api.putRequest(
        url: Endpoints.addPanCard, requireAuth: true, body: {"pancardNumber": panNumber, "pancardImg": panName, "cardHolderName": imageUrl});

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}");
      return null;
    }, (Response response) {
      return response;
    });
  }

  Future<Response?> add_Bank_details({required String accNumber, required String bankName, required String ifsc_Code}) async {
    final result = await _api
        .putRequest(url: Endpoints.addBankDetails, requireAuth: true, body: {"accountnumber": accNumber, "ifsc": ifsc_Code, "bankname": bankName});

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}");
      return null;
    }, (Response response) {
      return response;
    });
  }

  Future<Response?> add_gst({required String gstNumber, required String gstImage}) async {
    final result = await _api.putRequest(url: Endpoints.addgst, requireAuth: true, body: {"gstImg": gstImage, "gstNumber": gstNumber});

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}");
      return null;
    }, (Response response) {
      return response;
    });
  }

  Future<Response?> add_fssai({required String fssaiImage}) async {
    final result = await _api.putRequest(url: Endpoints.addfssai, requireAuth: true, body: {"fssaiImg": "dvftgh"});

    return result.fold((Failure failure) {
      log("Failed to fetch - ${failure.message}");
      return null;
    }, (Response response) {
      return response;
    });
  }
}
