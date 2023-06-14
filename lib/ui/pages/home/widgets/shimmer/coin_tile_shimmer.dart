import 'package:cryptotracker_app/shared/theme.dart';
import 'package:flutter/material.dart';

class CoinTileShimmer extends StatelessWidget {
  const CoinTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      margin: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteColor,
      ),
    );
  }
}
