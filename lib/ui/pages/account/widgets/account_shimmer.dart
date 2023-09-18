import 'package:cryptotracker_app/shared/theme.dart';
import 'package:flutter/material.dart';

class AccountShimmer extends StatelessWidget {
  const AccountShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20,
          width: 40,
          decoration: BoxDecoration(
            color: whiteColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(
                    color: whiteColor,
                  ),
                ),
                subtitle: Container(
                  height: 20,
                  width: 50,
                  decoration: BoxDecoration(
                    color: whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Container(
          height: 20,
          width: 40,
          decoration: BoxDecoration(
            color: whiteColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(
                    color: whiteColor,
                  ),
                ),
                subtitle: Container(
                  height: 20,
                  width: 50,
                  decoration: BoxDecoration(
                    color: whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
