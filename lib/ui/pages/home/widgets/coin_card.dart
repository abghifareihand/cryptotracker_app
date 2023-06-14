import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptotracker_app/models/coin_model.dart';
import 'package:cryptotracker_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinCard extends StatelessWidget {
  final CoinModel coin;
  const CoinCard({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        height: 115,
        margin: const EdgeInsets.only(
          left: 16,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.all(8),
                  child: CachedNetworkImage(
                    imageUrl: coin.image ??
                        'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: primaryNavbarColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coin.symbol!.toUpperCase(),
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Text(
                        coin.name!,
                        overflow: TextOverflow.ellipsis,
                        style: greyTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Text(
                currencyFormatter.format(coin.currentPrice),
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
