import 'package:cryptotracker_app/models/coin_model.dart';
import 'package:cryptotracker_app/models/news_model.dart';
import 'package:dio/dio.dart';

class ApiServices {
  Future<List<CoinModel>> coinList() async {
    const String baseUrl =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=idr&sparkline=true';
    final dio = Dio();
    var response = await dio.get(baseUrl);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      //debugPrint("API CRYPTO : $data");
      return data.map((item) => CoinModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load character');
    }
  }

  Future<List<Data>> newsList() async {
    const String baseUrl =
        'https://api.coingecko.com/api/v3/news'; // Ganti dengan URL API yang sesuai
    final dio = Dio();
    var response = await dio.get(baseUrl);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      // debugPrint("API BERITA : $data");
      return data.map((item) => Data.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load character');
    }
  }

  Future<List<dynamic>> getMarketChart(String id, int days) async {
    final String baseUrl =
        'https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=idr&days=$days';
    final Dio dio = Dio();
    final response = await dio.get(baseUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final List<dynamic> prices = data['prices'];
      return prices;
    } else {
      throw Exception('Failed to load market chart data');
    }
  }
}
