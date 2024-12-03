import 'dart:convert';

import 'package:biteblitz/src/features/bank_details/repo/bankDetails_repo.dart';
import 'package:biteblitz/src/models/bankData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a provider for the BankAccountsNotifier
final bankAccountsProvider = StateNotifierProvider<BankAccountsNotifier, List<BankDataModel>>((ref) {
  final BankDetailsRepo = ref.watch(BankDetailsRepoProvider);

  return BankAccountsNotifier(BankDetailsRepo);
});

class BankAccountsNotifier extends StateNotifier<List<BankDataModel>> {
  final BankDetailsRepo _bankAccRepo;

  BankAccountsNotifier(this._bankAccRepo) : super([]);

  Future<void> fetchAccounts() async {
    final response = await _bankAccRepo.getBankS();
    final Map<String, dynamic> responseBody = json.decode(response!.body);

    if (response.statusCode == 200 && responseBody['success'] == true) {
      final List<dynamic> bankData = responseBody['data'];

      List<BankDataModel> BankList = bankData.map((item) => BankDataModel.fromJson(item)).toList();
      state = BankList;
    }
  }

// Delete a bank account by ID
  Future<void> deleteAccount(String id, BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    final response = await _bankAccRepo.deleteBankAccount(id: id);
    final Map<String, dynamic> responseBody = json.decode(response!.body);

    if (response.statusCode == 200 && responseBody['success'] == true) {

      await fetchAccounts();
    } else {
      throw Exception('Failed to delete account');
    }
  }
}
