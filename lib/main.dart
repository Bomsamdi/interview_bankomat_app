import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_bankomat_app/constants.dart';
import 'package:interview_bankomat_app/dialogs/dialogs.dart';
import 'package:interview_bankomat_app/exceptions/atm_exception.dart';
import 'package:interview_bankomat_app/exceptions/empty_value_exception.dart';
import 'package:interview_bankomat_app/exceptions/wrong_value_exception.dart';
import 'package:interview_bankomat_app/extensions/map_extension.dart';
import 'package:interview_bankomat_app/providers/atm_provider.dart';
import 'package:interview_bankomat_app/types/user_balance.dart';
import 'package:interview_bankomat_app/widgets/balance_text.dart';

void main() {
  runApp(const ProviderScope(child: AtmApp()));
}

class AtmApp extends StatelessWidget {
  const AtmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AtmScreen(),
    );
  }
}

class AtmScreen extends ConsumerStatefulWidget {
  const AtmScreen({super.key});

  @override
  ConsumerState<AtmScreen> createState() => _AtmScreenState();
}

class _AtmScreenState extends ConsumerState<AtmScreen> {
  final TextEditingController withdrawValueController = TextEditingController();
  @override
  void dispose() {
    withdrawValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserBalance balance =
        ref.watch(atmProvider.select((state) => state.balance));
    final Map<int, int> atmBalance =
        ref.watch(atmProvider.select((state) => state.numberOfDenominations));
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Tooltip(
                      message: atmBalance.balanceTooltipString,
                      triggerMode: TooltipTriggerMode.tap,
                      child: BalanceText(
                        balanceText: Constants.atmBalance,
                        balanceValue: "${atmBalance.balance} zł",
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: BalanceText(
                      balanceText: Constants.userBalance,
                      balanceValue: balance.toCurrency(),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: withdrawValueController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration:
                    const InputDecoration(labelText: Constants.withdrawValue),
              ),
              const SizedBox(height: 64),
              ElevatedButton(
                onPressed: () {
                  try {
                    if (withdrawValueController.text.isEmpty) {
                      throw const EmptyValueException();
                    } else {
                      int? kwota = int.tryParse(withdrawValueController.text);
                      if (kwota == null) {
                        throw const WrongValueException();
                      } else if (kwota % 10 != 0) {
                        throw const WrongValueException(
                            aditionalInfo: Constants.wrongValueAditionalInfo);
                      } else {
                        ref.read(atmProvider.notifier).withdraw(context, kwota);
                      }
                    }
                  } on AtmException catch (e) {
                    Dialogs.of(context).showErrorDialog(e.title, e.toString());
                  } catch (e) {
                    Dialogs.of(context).showErrorDialog(
                      Constants.errorTitle,
                      Constants.unknownError,
                    );
                  }
                },
                child: const Text(Constants.withdraw),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
