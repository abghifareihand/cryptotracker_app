class CoinModel {
  CoinModel({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.totalVolume,
    this.high24,
    this.low24,
    this.priceChange24,
    this.priceChangePercentage24,
    this.circulatingSupply,
    this.ath,
    this.atl,
    this.marketCapChangePercentage24H,
    this.sparklineIn7D,
    this.isFavorite = false,
  });

  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  double? totalVolume;
  double? high24;
  double? low24;
  double? priceChange24;
  double? priceChangePercentage24;
  double? circulatingSupply;
  double? ath;
  double? atl;
  double? marketCapChangePercentage24H;
  SparklineIn7D? sparklineIn7D;
  bool isFavorite;

  factory CoinModel.fromJson(Map<String, dynamic> json) => CoinModel(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        image: json['image'],
        currentPrice: double.parse(json['current_price'].toString()),
        marketCap: double.parse(json['market_cap'].toString()),
        marketCapRank: json['market_cap_rank'],
        totalVolume: double.parse(json['total_volume'].toString()),
        high24: double.parse(json['high_24h'].toString()),
        low24: double.parse(json['low_24h'].toString()),
        priceChange24: double.parse(json['price_change_24h'].toString()),
        priceChangePercentage24:
            double.parse(json['price_change_percentage_24h'].toString()),
        circulatingSupply: double.parse(json['circulating_supply'].toString()),
        ath: double.parse(json['ath'].toString()),
        atl: double.parse(json['atl'].toString()),
        marketCapChangePercentage24H:
            double.parse(json['market_cap_change_percentage_24h'].toString()),
        sparklineIn7D: SparklineIn7D.fromJson(json["sparkline_in_7d"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
        "image": image,
        "current_price": currentPrice,
        "market_cap": marketCap,
        "market_cap_rank": marketCapRank,
        "total_volume": totalVolume,
        "high_24h": high24,
        "low_24h": low24,
        "price_change_24h": priceChange24,
        "price_change_percentage_24h": priceChangePercentage24,
        "circulating_supply": circulatingSupply,
        "ath": ath,
        "atl": atl,
        "market_cap_change_percentage_24h": marketCapChangePercentage24H,
        "sparkline_in_7d": sparklineIn7D!.toJson(),
      };
}

class SparklineIn7D {
  SparklineIn7D({
    required this.price,
  });

  List<double> price;

  factory SparklineIn7D.fromJson(Map<String, dynamic> json) => SparklineIn7D(
        price: List<double>.from(json["price"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "price": List<dynamic>.from(price.map((x) => x)),
      };
}
