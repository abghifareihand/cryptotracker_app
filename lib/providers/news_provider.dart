import 'package:cryptotracker_app/models/news_model.dart';
import 'package:cryptotracker_app/services/api_services.dart';
import 'package:flutter/material.dart';

enum ResultState {
  none,
  loading,
  error,
}

class NewsProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();

  ResultState _state = ResultState.none;
  ResultState get state => _state;

  List<Data> _news = [];
  List<Data> get news => _news;

  newsProvider() {
    getAllNews();
  }

  void getAllNews() async {
    _state = ResultState.loading;
    try {
      final response = await apiServices.newsList();
      _news = response;
      //sortNewsByPublishAt();
      notifyListeners();
      _state = ResultState.none;
    } catch (e) {
      _state = ResultState.error;
    }
  }
}
