import 'package:flutter/material.dart';
import 'package:interview_bankomat_app/constants.dart';
import 'package:interview_bankomat_app/extensions/map_extension.dart';

class Dialogs {
  final BuildContext context;
  const Dialogs(this.context);
  static Dialogs of(BuildContext context) => Dialogs(context);

  void showWithdrawDialog(Map<int, int> result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Constants.withdrawTitle),
          content: Text(
              "${Constants.withdrawMessage} ${result.balance} zł (${result.balanceString})."),
          actions: <Widget>[
            TextButton(
              child: const Text(Constants.confirm),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              child: const Text(Constants.confirm),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
