import 'dart:convert';

import 'package:news_app/core/constants/storage_keys.dart';
import 'package:news_app/services/news_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllFunction {
  List<Map<String, dynamic>> newsList = [];
  List<Map<String, dynamic>> searchNewsList = [];

  List<Map<String, dynamic>> trendingList = [];
  List<Map<String, dynamic>> bookmarkList = [];

  static final NewsService _newsService = NewsService();
  bool isLoading = false;
  late final SharedPreferences _sharedPreferences;

  /// executes at initial state while building

  /// gets data info for every three hours from the current time
  getNews(q) async {
    newsList = await _newsService.getNewsByKeyword(q: q ?? "Entertainment");
  }

  getSearchNews(q) async {
    searchNewsList =
        await _newsService.getNewsByKeyword(q: q ?? "Entertainment");
  }

  getTrendingAndLatest() async {
    trendingList = await _newsService.getTrendingNews();
  }

  addBookmark(Map<String, dynamic> item) {
    bookmarkList.add(item);
    print(bookmarkList);
    print(bookmarkList.length);
  }
}
