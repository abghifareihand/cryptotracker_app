import 'package:cryptotracker_app/shared/theme.dart';
import 'package:flutter/material.dart';

class CoinCardShimmer extends StatelessWidget {
  const CoinCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 115,
      margin: const EdgeInsets.only(
        left: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteColor,
      ),
    );
  }
}
