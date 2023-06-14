import 'package:cryptotracker_app/shared/theme.dart';
import 'package:flutter/material.dart';

class NewsTileShimmer extends StatelessWidget {
  const NewsTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 16,
            right: 16,
            left: 16,
          ),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: whiteColor,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 150,
                      decoration: BoxDecoration(
                        color: whiteColor,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 20,
                      width: 120,
                      decoration: BoxDecoration(
                        color: whiteColor,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
