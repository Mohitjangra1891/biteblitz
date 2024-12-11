import 'dart:convert';

import 'package:biteblitz/src/common/providers/common_providers.dart';
import 'package:biteblitz/src/common/services/snackBar_service.dart';
import 'package:biteblitz/src/utils/SharedPrefHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/router.dart';
import '../repo/auth_repository.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepoProvider);
  return AuthNotifier(authRepository);
});

// Provider to listen to the login state only
final loginStateProvider = Provider<AsyncValue<void>>((ref) {
  return ref.watch(authProvider.select((authState) => authState.loginState));
});

// Provider to listen to the register state only
final registerStateProvider = Provider<AsyncValue<void>>((ref) {
  return ref.watch(authProvider.select((authState) => authState.registerState));
});

// Provider to listen to the verify OTP state only
final verifyOtpStateProvider = Provider<AsyncValue<void>>((ref) {
  return ref.watch(authProvider.select((authState) => authState.verifyOtpState));
});
final addPanCardStateProvider = Provider<AsyncValue<void>>((ref) {
  return ref.watch(authProvider.select((authState) => authState.panCardState));
});

final addBankDetailsStateProvider = Provider<AsyncValue<void>>((ref) {
  return ref.watch(authProvider.select((authState) => authState.bankDetailState));
});

final addgstInStateProvider = Provider<AsyncValue<void>>((ref) {
  return ref.watch(authProvider.select((authState) => authState.gstInState));
});
final addFssaiStateProvider = Provider<AsyncValue<void>>((ref) {
  return ref.watch(authProvider.select((authState) => authState.fssaiState));
});

// State class to hold the individual states for login, register, and verify OTP
class AuthState {
  final AsyncValue<void> loginState;
  final AsyncValue<void> registerState;
  final AsyncValue<void> verifyOtpState;
  final AsyncValue<void> panCardState;
  final AsyncValue<void> bankDetailState;
  final AsyncValue<void> gstInState;
  final AsyncValue<void> fssaiState;

  AuthState({
    this.loginState = const AsyncValue.data(null),
    this.registerState = const AsyncValue.data(null),
    this.verifyOtpState = const AsyncValue.data(null),
    this.panCardState = const AsyncValue.data(null),
    this.bankDetailState = const AsyncValue.data(null),
    this.gstInState = const AsyncValue.data(null),
    this.fssaiState = const AsyncValue.data(null),
  });

  AuthState copyWith({
    AsyncValue<void>? loginState,
    AsyncValue<void>? registerState,
    AsyncValue<void>? verifyOtpState,
    AsyncValue<void>? panCardState,
    AsyncValue<void>? bankDetailState,
    AsyncValue<void>? gstInState,
    AsyncValue<void>? fssaiState,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      registerState: registerState ?? this.registerState,
      verifyOtpState: verifyOtpState ?? this.verifyOtpState,
      panCardState: panCardState ?? this.panCardState,
      bankDetailState: bankDetailState ?? this.bankDetailState,
      gstInState: gstInState ?? this.gstInState,
      fssaiState: fssaiState ?? this.fssaiState,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepo _authRepo;

  AuthNotifier(this._authRepo) : super(AuthState());

  // Login method
  Future<void> login(WidgetRef ref, BuildContext context, String email, String password) async {
    try {
      state = state.copyWith(loginState: const AsyncValue.loading());
      final response = await _authRepo.login(email: email, password: password);
      final Map<String, dynamic> responseBody = json.decode(response!.body);

      if (response.statusCode == 200 && responseBody['success'] == true) {
        SnackBarService.showSnackBar(context: context, message: responseBody['message']);

        final authToken = ref.read(authTokenProvider.notifier).state = responseBody['data'];
        SharedPrefHelper.saveToken(authToken);
        context.go(routeNames.dashboard);
        // context.go(routeNames.verification);
      } else {
        SnackBarService.showSnackBar(context: context, message: responseBody['message']);
      }

      state = state.copyWith(loginState: const AsyncValue.data(null));
    } catch (error, stackTrace) {
      state = state.copyWith(loginState: AsyncValue.error(error, stackTrace));
    }
  }

  // Register method
  Future<bool> register(WidgetRef ref, BuildContext context, String name, String email, String password) async {
    try {
      state = state.copyWith(registerState: const AsyncValue.loading());

      final body = {"name": name, "email": email, "password": password};
      final response = await _authRepo.register(body: body);

      final Map<String, dynamic> responseBody = json.decode(response!.body);

      if (response.statusCode == 200 && responseBody['success'] == true) {
        final authToken = ref.read(authTokenProvider.notifier).state = responseBody['data'];
        SharedPrefHelper.saveToken(authToken);
        SharedPrefHelper.saveValue(SharedPrefKeys.restaurantName, name);
        SharedPrefHelper.saveValue(SharedPrefKeys.restaurantEmail, email);
        // final otp_response = await _authRepo.verifyOtp(number: "8307251891", otp: "1234");
        // final Map<String, dynamic> otp_responseBody = json.decode(otp_response!.body);
        //
        // if (otp_response.statusCode == 200 && otp_responseBody['success'] == true) {
        //   SnackBarService.showSnackBar(context: context, message: otp_responseBody['message']);
        SharedPrefHelper.saveValue(SharedPrefKeys.onboarding_stage, 0);

        context.go(routeNames.verification);
        // } else {
        //   SnackBarService.showSnackBar(context: context, message: otp_responseBody['message']);
        // }
      } else {
        SnackBarService.showSnackBar(context: context, message: responseBody['message']);
        state = state.copyWith(registerState: const AsyncValue.data(null));

        return false;
      }
      state = state.copyWith(registerState: const AsyncValue.data(null));
      return true;
    } catch (error, stackTrace) {
      state = state.copyWith(registerState: AsyncValue.error(error, stackTrace));
      return false;
    }
  }

  // Verify OTP method
  // Future<void> verifyOtp(String phoneNumber, String otp, BuildContext context) async {
  //   try {
  //     state = state.copyWith(verifyOtpState: const AsyncValue.loading());
  //     final response = await _authRepo.verifyOtp(number: phoneNumber, otp: otp);
  //     final Map<String, dynamic> responseBody = json.decode(response!.body);
  //
  //     if (response.statusCode == 200 && responseBody['success'] == true) {
  //       SnackBarService.showSnackBar(context: context, message: responseBody['message']);
  //     } else {
  //       SnackBarService.showSnackBar(context: context, message: responseBody['message']);
  //     }
  //
  //     state = state.copyWith(verifyOtpState: const AsyncValue.data(null));
  //   } catch (error, stackTrace) {
  //     state = state.copyWith(verifyOtpState: AsyncValue.error(error, stackTrace));
  //   }
  // }

  ///region add pan Card method
  Future<void> addPanCard(WidgetRef red, BuildContext context, {required String panNumber, required String panName, required String imageUrl}) async {
    try {
      state = state.copyWith(panCardState: const AsyncValue.loading());

      final response = await _authRepo.add_PanCard_details(panNumber: panNumber, panName: panName, imageUrl: imageUrl);

      final Map<String, dynamic> responseBody = json.decode(response!.body);
      if (response.statusCode == 200 && responseBody['success'] == true) {
        SnackBarService.showSnackBar(context: context, message: responseBody['message']);
        SharedPrefHelper.saveValue(SharedPrefKeys.onboarding_stage, 3);

        context.go(routeNames.addBank_during_registraton);
      } else {
        SnackBarService.showSnackBar(context: context, message: responseBody['message']);
      }

      state = state.copyWith(panCardState: const AsyncValue.data(null));
    } catch (error, stackTrace) {
      state = state.copyWith(panCardState: AsyncValue.error(error, stackTrace));
    }
  }

  ///endregion

  ///region add Bank details method
  Future<void> addBankDetails(WidgetRef red, BuildContext context,
      {required String accNumber, required String bankName, required String ifsc_code}) async {
    try {
      state = state.copyWith(bankDetailState: const AsyncValue.loading());

      final response = await _authRepo.add_Bank_details(accNumber: accNumber, bankName: bankName, ifsc_Code: ifsc_code);

      final Map<String, dynamic> responseBody = json.decode(response!.body);
      if (response.statusCode == 200 && responseBody['success'] == true) {
        SnackBarService.showSnackBar(context: context, message: responseBody['message']);
        SharedPrefHelper.saveValue(SharedPrefKeys.onboarding_stage, 4);

        context.go(routeNames.addMenuImages_during_register);
      } else {
        SnackBarService.showSnackBar(context: context, message: responseBody['message']);
      }

      state = state.copyWith(bankDetailState: const AsyncValue.data(null));
    } catch (error, stackTrace) {
      state = state.copyWith(bankDetailState: AsyncValue.error(error, stackTrace));
    }
  }

  ///endregion
  ///

  ///region add gstIn method
  Future<void> addgstIn(WidgetRef red, BuildContext context, {required String gstNumber, required String gstImage}) async {
    try {
      state = state.copyWith(gstInState: const AsyncValue.loading());

      final response = await _authRepo.add_gst(gstNumber: gstNumber, gstImage: gstImage);

      final Map<String, dynamic> responseBody = json.decode(response!.body);
      if (response.statusCode == 200 && responseBody['success'] == true) {
        SnackBarService.showSnackBar(context: context, message: responseBody['message']);
        SharedPrefHelper.saveValue(SharedPrefKeys.onboarding_stage, 7);

        context.go(routeNames.pendingVerification);
      } else {
        SnackBarService.showSnackBar(context: context, message: responseBody['message']);
      }

      state = state.copyWith(gstInState: const AsyncValue.data(null));
    } catch (error, stackTrace) {
      state = state.copyWith(gstInState: AsyncValue.error(error, stackTrace));
    }
  }

  ///endregion

  ///region add gstIn method
  Future<void> addfssai(WidgetRef red, BuildContext context, {required String fssaiImage}) async {
    try {
      state = state.copyWith(fssaiState: const AsyncValue.loading());

      final response = await _authRepo.add_fssai(fssaiImage: fssaiImage);

      final Map<String, dynamic> responseBody = json.decode(response!.body);
      if (response.statusCode == 200 && responseBody['success'] == true) {
        SnackBarService.showSnackBar(context: context, message: responseBody['message']);
        SharedPrefHelper.saveValue(SharedPrefKeys.onboarding_stage, 6);

        context.go(routeNames.addGSTin);
      } else {
        SnackBarService.showSnackBar(context: context, message: responseBody['message']);
      }

      state = state.copyWith(fssaiState: const AsyncValue.data(null));
    } catch (error, stackTrace) {
      state = state.copyWith(fssaiState: AsyncValue.error(error, stackTrace));
    }
  }

  ///endregion
  ///
}
