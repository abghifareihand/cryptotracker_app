import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptotracker_app/providers/coin_provider.dart';
import 'package:cryptotracker_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cryptotracker_app/models/coin_model.dart';
import 'package:cryptotracker_app/services/api_services.dart';

class CoinDetailPage extends StatefulWidget {
  final CoinModel coin;

  CoinDetailPage({required this.coin});

  @override
  _CoinDetailPageState createState() => _CoinDetailPageState();
}

class _CoinDetailPageState extends State<CoinDetailPage> {
  final currencyFormatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
  final ApiServices apiServices = ApiServices();
  List<ChartSampleData> chartData = [];
  String selectedTab = '1D';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getMarketChart('1D');
  }

  Future<void> getMarketChart(String interval) async {
    setState(() {
      isLoading = true;
    });

    try {
      int days = 1;
      if (interval == '7D') {
        days = 7;
      } else if (interval == '14D') {
        days = 14;
      } else if (interval == '1M') {
        days = 30;
      } else if (interval == '3M') {
        days = 90;
      }

      List<dynamic> data =
          await apiServices.getMarketChart(widget.coin.id!, days);
      setState(() {
        chartData = data
            .map((dynamic item) => ChartSampleData(
                  x: DateTime.fromMillisecondsSinceEpoch(item[0]),
                  y: item[1],
                ))
            .toList();
        selectedTab = interval;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF8F8F8),
        elevation: 0.0,
        centerTitle: true,
        toolbarHeight: 80, // Atur tinggi AppBar menjadi 80
        title: Text(
          widget.coin.name!,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(16), // Atur padding keseluruhan pada leading
          child: IconButton(
            iconSize: 20, // Menggunakan iconSize untuk mengatur ukuran ikon
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding:
                EdgeInsets.all(16), // Atur padding keseluruhan pada actions
            child: Consumer<CoinProvider>(
              builder: (context, coinProvider, _) {
                bool isFavorite = coinProvider.isFavorite(widget.coin);
                return IconButton(
                  iconSize:
                      24, // Menggunakan iconSize untuk mengatur ukuran ikon
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                  onPressed: () {
                    Provider.of<CoinProvider>(context, listen: false)
                        .toggleFavorite(widget.coin);
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            CircleAvatar(
              radius: 54,
              backgroundColor: Colors.grey.withOpacity(0.3),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: widget.coin.image ??
                      'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg',
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: primaryNavbarColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              '${currencyFormatter.format(widget.coin.currentPrice)}',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: widget.coin.priceChangePercentage24! >= 0
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2),
              ),
              child: Text(
                '${widget.coin.priceChangePercentage24!.toStringAsFixed(1)}%',
                style: widget.coin.priceChangePercentage24! >= 0
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
            SizedBox(height: 24),
            Container(
              height: 300,
              child: isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator(color: primaryNavbarColor),
                    )
                  : SfCartesianChart(
                      primaryXAxis: DateTimeAxis(),
                      primaryYAxis: NumericAxis(
                        numberFormat: NumberFormat.currency(
                            locale: 'id_ID', symbol: 'Rp', decimalDigits: 0),
                      ),
                      series: <ChartSeries>[
                        AreaSeries<ChartSampleData, DateTime>(
                          dataSource: chartData,
                          xValueMapper: (ChartSampleData data, _) => data.x,
                          yValueMapper: (ChartSampleData data, _) => data.y,
                          color: _getLineColor(),
                          borderColor: _getBorderColor(),
                          borderWidth: 2,
                        ),
                      ],
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePanning: true,
                        enableDoubleTapZooming: true,
                      ),
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        duration: 1,
                        header: '',
                        format: 'Date: point.x\nPrice: point.y',
                        color: whiteColor,
                        textStyle: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTab('1D'),
                  _buildTab('7D'),
                  _buildTab('14D'),
                  _buildTab('1M'),
                  _buildTab('3M'),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Market Cap Rank:',
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    '#${widget.coin.marketCapRank}',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Market Cap:',
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    '${currencyFormatter.format(widget.coin.marketCap)}',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Total Volume:',
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    '${currencyFormatter.format(widget.coin.totalVolume)}',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '24H High:',
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    '${currencyFormatter.format(widget.coin.high24)}',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '24H Low:',
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    '${currencyFormatter.format(widget.coin.low24)}',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBorderColor() {
    if (chartData.isNotEmpty) {
      num lastValue = chartData.last.y;
      num secondLastValue =
          chartData.length >= 2 ? chartData[chartData.length - 2].y : 0;

      if (lastValue > secondLastValue) {
        // Market naik
        return Colors.green;
      } else if (lastValue < secondLastValue) {
        // Market turun
        return Colors.red;
      }
    }

    // Warna default jika data kosong
    return Colors.blue;
  }

  Color _getLineColor() {
    if (chartData.isNotEmpty) {
      num lastValue = chartData.last.y;
      num secondLastValue =
          chartData.length >= 2 ? chartData[chartData.length - 2].y : 0;

      if (lastValue > secondLastValue) {
        // Market naik
        return Colors.green.withOpacity(0.2);
      } else if (lastValue < secondLastValue) {
        // Market turun
        return Colors.red.withOpacity(0.2);
      }
    }

    // Warna default jika data kosong
    return Colors.blue.withOpacity(0.5);
  }

  Widget _buildTab(String interval) {
    return GestureDetector(
      onTap: () {
        getMarketChart(interval);
      },
      child: Container(
        width: 46,
        height: 32,
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color:
              selectedTab == interval ? primaryNavbarColor : Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            interval,
            style: TextStyle(
              color: selectedTab == interval ? whiteColor : greyColor,
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      ),
    );
  }
}

class ChartSampleData {
  final DateTime x;
  final double y;

  ChartSampleData({required this.x, required this.y});
}
