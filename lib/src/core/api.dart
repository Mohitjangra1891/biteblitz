import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import '../common/providers/common_providers.dart';
import '../res/strings.dart';
import '../utils/config.dart';
import 'core.dart';

final apiProvider = StateProvider((ref) {
  final authToken = ref.watch(authTokenProvider);

  // final token = await SharedPrefHelper.getToken();
  return API(authToken: authToken);
});

class API {
  final String? _authToken;

  API({required String? authToken}) : _authToken = authToken;

  FutureEither<Response> getRequest({required String url, bool requireAuth = true}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "$_authToken"
    };
    if (requireAuth) {
      if ((_authToken ?? '').isEmpty) {
        return Left(Failure(message: FailureMessage.authTokenEmpty));
      }
    }
    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: LogLabel.httpGet);
      log('requireAuth : $requireAuth', name: LogLabel.httpGet);
    }
    try {
      final response = await get(Uri.parse(url), headers: requestHeaders);
      log('RESPONSE : ${response.body}\n', name: LogLabel.httpGet);
      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
          message: FailureMessage.getRequestMessage, stackTrace: stktrc));
    }
  }

  FutureEither<Response> postRequest({required String url, dynamic body, bool requireAuth = true}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "$_authToken"
    };
    if (requireAuth) {
      if ((_authToken ?? '').isEmpty) {
        return Left(Failure(message: FailureMessage.authTokenEmpty));
      }
    }
    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: LogLabel.httpPost);
      log('requireAuth : $requireAuth', name: LogLabel.httpPost);
      log('BODY : $body', name: LogLabel.httpPost);
    }
    try {
      final response = await post(Uri.parse(url),
          body: jsonEncode(body), headers: requestHeaders);
      log('RESPONSE :${response.statusCode}- ${response.body}\n', name: LogLabel.httpPost);
      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
          message: FailureMessage.postRequestMessage, stackTrace: stktrc));
    }
  }

  FutureEither<Response> putRequest({required String url, dynamic body, bool requireAuth = true}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "$_authToken"
    };
    if (requireAuth) {
      if ((_authToken ?? '').isEmpty) {
        return Left(Failure(message: FailureMessage.authTokenEmpty));
      }
    }
    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: LogLabel.httpPut);
      log(
        'requireAuth : $requireAuth',
        name: LogLabel.httpPut,
      );
      log('BODY : $body', name: LogLabel.httpPut);
      log('Token : $_authToken', name: "TOKEN");
    }
    try {
      final response = await put(Uri.parse(url),
          body: jsonEncode(body), headers: requestHeaders);
      log('RESPONSE : ${response.body}\n', name: LogLabel.httpPut);
      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
          message: FailureMessage.putRequestMessage, stackTrace: stktrc));
    }
  }

  FutureEither<Response> deleteRequest({required String url, dynamic body, bool requireAuth = true}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "$_authToken"
    };
    if (requireAuth) {
      if ((_authToken ?? '').isEmpty) {
        return Left(Failure(message: FailureMessage.authTokenEmpty));
      }
    }
    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: LogLabel.httpDelete);
      log('requireAuth : $requireAuth', name: LogLabel.httpDelete);
      log('BODY : $body', name: LogLabel.httpDelete);
    }
    try {
      final response = await delete(Uri.parse(url),
          body: jsonEncode(body), headers: requestHeaders);
      log('RESPONSE : ${response.body}\n', name: LogLabel.httpDelete);
      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
          message: FailureMessage.deleteRequestMessage, stackTrace: stktrc));
    }
  }
}
