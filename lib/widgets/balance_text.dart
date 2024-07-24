import 'package:flutter/material.dart';

class BalanceText extends StatelessWidget {
  const BalanceText({
    super.key,
    required this.balanceText,
    required this.balanceValue,
  });
  final String balanceText;
  final String balanceValue;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(text: '$balanceText: '),
          TextSpan(
            text: balanceValue,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
        style: const TextStyle(fontSize: 20),
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
