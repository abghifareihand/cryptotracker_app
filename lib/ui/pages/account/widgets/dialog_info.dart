import 'package:cryptotracker_app/shared/theme.dart';
import 'package:flutter/material.dart';

class DialogInfo extends StatelessWidget {
  final String title;
  final String content;

  const DialogInfo({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: blackTextStyle.copyWith(
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryNavbarColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
