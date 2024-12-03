import 'dart:convert';
import 'dart:developer';

import 'package:biteblitz/src/common/services/snackBar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/router.dart';
import '../repo/menu_repo.dart';

final menu_Controller_Provider = StateNotifierProvider<MenuNotifier, MenuState>((ref) {
  final menuRepository = ref.watch(menuRepoProvider);
  return MenuNotifier(menuRepository);
});

final getAllMenuItems_StateProvider = Provider<AsyncValue<void>>((ref) {
  return ref.watch(menu_Controller_Provider.select((menuState) => menuState.getAllMenuItems));
});

final addNewMenuItem_StateProvider = Provider<AsyncValue<void>>((ref) {
  return ref.watch(menu_Controller_Provider.select((menuState) => menuState.addNewMenuItem));
});

class MenuState {
  final AsyncValue<void> getAllMenuItems;
  final AsyncValue<void> addNewMenuItem;

  MenuState({
    this.getAllMenuItems = const AsyncValue.data(null),
    this.addNewMenuItem = const AsyncValue.data(null),
  });

  MenuState copyWith({
    AsyncValue<void>? getAllMenuItems,
    AsyncValue<void>? addNewMenuItem,
  }) {
    return MenuState(
      getAllMenuItems: getAllMenuItems ?? this.getAllMenuItems,
      addNewMenuItem: addNewMenuItem ?? this.addNewMenuItem,
    );
  }
}

class MenuNotifier extends StateNotifier<MenuState> {
  final MenuRepo _menuRepo;

  MenuNotifier(this._menuRepo) : super(MenuState());

  //
  // Future<void> getAllMenuItems(WidgetRef ref, BuildContext context) async {
  //   try {
  //     state = state.copyWith(getAllMenuItems: const AsyncValue.loading());
  //     final response = await _menuRepo.getAllMenuItems();
  //     final Map<String, dynamic> responseBody = json.decode(response!.body);
  //
  //     if (response.statusCode == 200 && responseBody['success'] == true) {
  //       SnackBarService.showSnackBar(context: context, message: responseBody['message']);
  //
  //     } else {
  //       SnackBarService.showSnackBar(context: context, message: responseBody['message']);
  //     }
  //
  //     state = state.copyWith(getAllMenuItems: const AsyncValue.data(null));
  //   } catch (error, stackTrace) {
  //     state = state.copyWith(getAllMenuItems: AsyncValue.error(error, stackTrace));
  //   }
  // }

  ///region add New Menu Item method
  Future<void> addNewMenuItem(WidgetRef red, BuildContext context,
      {required String name, required int price, required String category, required String image, required bool isVeg}) async {
    try {
      state = state.copyWith(addNewMenuItem: const AsyncValue.loading());

      final response = await _menuRepo.addNewMenuItem(name: name, price: price, category: category, image: image, isVeg: isVeg);

      final Map<String, dynamic> responseBody = json.decode(response!.body);
      if (response.statusCode == 200 && responseBody['success'] == true) {
        SnackBarService.showSnackBar(context: context, message: responseBody['data']);
        // print(responseBody['message']);

        context.replaceNamed(routeNames.item_added_successfully);
      } else {
        // print(responseBody['message']);

        SnackBarService.showSnackBar(context: context, message: responseBody['data']);
      }

      state = state.copyWith(addNewMenuItem: const AsyncValue.data(null));
    } catch (error, stackTrace) {
      // log("${error.toString()}",name: "addNewMenuItem/MenuController");
      // log("${stackTrace.toString()}",name: "addNewMenuItem/MenuController");

      state = state.copyWith(addNewMenuItem:  AsyncValue.error(error, stackTrace));
    }
  }

  ///endregion
}
