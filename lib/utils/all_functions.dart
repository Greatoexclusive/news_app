import 'dart:convert';

import 'package:news_app/core/constants/storage_keys.dart';
import 'package:news_app/services/news_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllFunction {
  List<Map<String, dynamic>> newsList = [];
  List<Map<String, dynamic>> bookmarkList = [];

  static final NewsService _newsService = NewsService();
  bool isLoading = false;
  late final SharedPreferences _sharedPreferences;

  /// executes at initial state while building

  /// gets data info for every three hours from the current time
  getNews(q) async {
    isLoading = true;
    newsList = await _newsService.getNewsByKeyword(q: q);
    isLoading = false;
  }

  addBookmark(Map<String, dynamic> item) {
    bookmarkList.add(item);
    saveBookmarkLocally();
  }

  saveBookmarkLocally() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    await _sharedPreferences.setString(
      StorageKeys.bookmarks,
      jsonEncode(bookmarkList),
    );
  }

  getBookmarkLocally() async {
    // _sharedPreferences = await SharedPreferences.getInstance();

    bookmarkList =
        jsonDecode(_sharedPreferences.getString(StorageKeys.bookmarks) ?? '[]')
            .map<Map<String, dynamic>>((e) => e as Map<String, dynamic>)
            .toList();
  }
}
