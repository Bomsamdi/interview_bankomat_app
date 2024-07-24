import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_bankomat_app/constants.dart';
import 'package:interview_bankomat_app/dialogs/dialogs.dart';
import 'package:interview_bankomat_app/exceptions/balance_exception.dart';
import 'package:interview_bankomat_app/exceptions/no_denominations_available_exception.dart';
import 'package:interview_bankomat_app/extensions/map_extension.dart';
import 'package:interview_bankomat_app/types/user_balance.dart';

final atmProvider = StateNotifierProvider<AtmNotifier, AtmState>((ref) {
  return AtmNotifier(AtmState(
    balance: UserBalance(4010),
    numberOfDenominations: {
      200: 4,
      100: 10,
      50: 0,
      20: 50,
      10: 0,
    },
  ));
});

class AtmState {
  final UserBalance balance;
  final Map<int, int> numberOfDenominations;

  AtmState({required this.balance, required this.numberOfDenominations});

  AtmState copyWith(
      {UserBalance? balance, Map<int, int>? numberOfDenominations}) {
    return AtmState(
      balance: balance ?? this.balance,
      numberOfDenominations:
          numberOfDenominations ?? this.numberOfDenominations,
    );
  }
}

class AtmNotifier extends StateNotifier<AtmState> {
  AtmNotifier(super.bankomatState);

  void withdraw(BuildContext context, int value) {
    if (value > state.balance) {
      throw const BalanceException();
    }

    Map<int, int> result = {};
    int rest = value;

    final numberOfDenominations =
        Map<int, int>.from(state.numberOfDenominations);

    for (int denomination in Constants.denominations) {
      int numberOfBanknotes = rest ~/ denomination;
      if (numberOfBanknotes > 0) {
        int availableBanknotes = numberOfDenominations[denomination]!;
        if (numberOfBanknotes > availableBanknotes) {
          numberOfBanknotes = availableBanknotes;
        }
        result[denomination] = numberOfBanknotes;
        rest -= denomination * numberOfBanknotes;
      }
    }

    if (rest != 0 && state.numberOfDenominations.balance < value) {
      throw NoDenominationsAvailableException(
          aditionalInfo:
              "${Constants.noDenominationsAvailableAdditionalInfo}${numberOfDenominations.balance} zł");
    } else if (rest != 0) {
      throw const NoDenominationsAvailableException();
    } else {
      state = state.copyWith(
        balance: state.balance - value,
        numberOfDenominations: {
          for (var entry in state.numberOfDenominations.entries)
            entry.key: entry.value - (result[entry.key] ?? 0)
        },
      );
      Dialogs.of(context).showWithdrawDialog(result);
    }
  }
}
