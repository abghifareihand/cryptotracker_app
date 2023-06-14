import 'package:cryptotracker_app/models/coin_model.dart';
import 'package:cryptotracker_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ResultState {
  none,
  loading,
  error,
}

class CoinProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  SharedPreferences? sharedPreferences;

  ResultState _state = ResultState.none;
  ResultState get state => _state;

  List<CoinModel> _coins = [];
  List<CoinModel> get coins => _coins;

  CoinProvider() {
    getAllCoins();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void getAllCoins() async {
    _state = ResultState.loading;
    try {
      final response = await apiServices.coinList();
      _coins = response;
      loadFavoritesFromSharedPreferences();
      notifyListeners();
      _state = ResultState.none;
    } catch (e) {
      _state = ResultState.error;
    }
  }

  bool isFavorite(CoinModel coin) {
    return coin.isFavorite;
  }

  void toggleFavorite(CoinModel coin) {
    coin.isFavorite = !coin.isFavorite;
    saveFavoritesToSharedPreferences();
    notifyListeners();
  }

  void loadFavoritesFromSharedPreferences() {
    for (CoinModel coin in _coins) {
      coin.isFavorite = sharedPreferences!.getBool(coin.id.toString()) ?? false;
    }
  }

  void saveFavoritesToSharedPreferences() {
    for (CoinModel coin in _coins) {
      sharedPreferences!.setBool(coin.id.toString(), coin.isFavorite);
    }
  }
}
