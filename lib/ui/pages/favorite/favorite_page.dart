import 'package:cached_network_image/cached_network_image.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:cryptotracker_app/models/coin_model.dart';
import 'package:cryptotracker_app/providers/coin_provider.dart';
import 'package:cryptotracker_app/shared/theme.dart';
import 'package:cryptotracker_app/ui/pages/home/detail_coin_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinProvider>(
      builder: (context, coinProvider, _) {
        List<CoinModel> favoriteCoins =
            coinProvider.coins.where((coin) => coin.isFavorite).toList();

        if (favoriteCoins.isEmpty) {
          return Center(
            child: Text(
              'No Data',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return Scaffold(
          backgroundColor: bgColor,
          body: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  top: 20,
                ),
                child: Text(
                  'Favorite Coin',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: favoriteCoins.length,
                itemBuilder: (context, index) {
                  CoinModel coin = favoriteCoins[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoinDetailPage(coin: coin),
                        ),
                      );
                    },
                    child: Container(
                      height: 68,
                      margin: const EdgeInsets.only(
                        top: 16,
                        right: 16,
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
                      child: Row(
                        children: [
                          // ICON, NAME, CODE,
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    margin: const EdgeInsets.only(
                                      left: 8,
                                      right: 16,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: coin.image ??
                                          'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: primaryNavbarColor,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        coin.symbol!.toUpperCase(),
                                        style: blackTextStyle.copyWith(
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: Text(
                                          coin.name!,
                                          overflow: TextOverflow.ellipsis,
                                          style: greyTextStyle.copyWith(
                                            fontWeight: semiBold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // SPARKLINE
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: deviceHeight(context) * 0.05,
                              width: deviceWidth(context) * 0.2,
                              child: Sparkline(
                                data: coin.sparklineIn7D!.price,
                                lineWidth: 2.0,
                                lineColor: coin.priceChangePercentage24! >= 0
                                    ? greenColor
                                    : redColor,
                              ),
                            ),
                          ),

                          // HARGA, PERCENT
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  '${coin.priceChangePercentage24!.toStringAsFixed(1)}%',
                                  style: coin.priceChangePercentage24! >= 0
                                      ? greenTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: semiBold,
                                        )
                                      : redTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: semiBold,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
