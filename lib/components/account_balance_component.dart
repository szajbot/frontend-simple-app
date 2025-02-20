import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../colors.dart';

class AccountBalanceComponent extends StatelessWidget {
  final double balance;

  const AccountBalanceComponent({
    Key? key,
    required this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(10, 20),
            ),
          ],
          gradient: LinearGradient(
              colors: [CustomColors.componentFont, CustomColors.background2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(math.pi / 4)
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Account Balance',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            '${balance.toStringAsFixed(2)} PLN',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.yellowAccent),
          ),
        ],
      ),
    );
  }
}
