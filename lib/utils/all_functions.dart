import 'package:flutter/material.dart';
import 'package:news_app/core/services/news_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllFunction {
  List<Map<String, dynamic>> newsList = [];
  List<Map<String, dynamic>> searchNewsList = [];
  List<Map<String, dynamic>> trendingList = [];
  List<Map<String, dynamic>> bookmarkList = [];
  int page = 1;

  static final NewsService _newsService = NewsService();
  bool isLoading = false;

  getNews(q) async {
    newsList.addAll(await _newsService.getNewsByKeyword(
        q: q ?? "Entertainment", page: page));
  }

  getSearchNews(q) async {
    searchNewsList = await _newsService.getNewsByKeyword(
        q: q ?? "Entertainment", page: page);
  }

  getTrendingAndLatest() async {
    trendingList = await _newsService.getTrendingNews();
  }

  addBookmark(Map<String, dynamic> item) {
    bookmarkList.add(item);
    print(bookmarkList.length);
  }

  removeBookmark(Map<String, dynamic> item) {
    bookmarkList.remove(item);
  }

  getMoreNews(q) {
    page++;
    getNews(q);
  }
}
