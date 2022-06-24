import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NewsService {
  final String hostKey = "free-news.p.rapidapi.com";
  final String apiKey = "148d48a70fmsh276705c95335d87p1b884cjsn5d365f301f60";
  final String host = "X-RapidAPI-Host";
  final String api = "X-RapidAPI-Key";
  final baseURL = "https://free-news.p.rapidapi.com";
  final String dateToday = DateFormat("yyyy-MM-dd").format(DateTime.now());
  late int totalPages;

  Future<List<Map<String, dynamic>>> getNewsByKeyword({
    required String q,
    required int page,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          "$baseURL/v1/search?q=$q&page=$page&page_size=10",
        ),
        headers: {
          host: hostKey,
          api: apiKey,
        },
      );

      final data = jsonDecode(response.body)["articles"];
      totalPages = jsonDecode(response.body)["total_pages"];
      // print(totalPages);
      // print(data);
      final List<Map<String, dynamic>> newsList =
          List<Map<String, dynamic>>.from(
        data.map((e) => e),
      );
      return newsList;
    } catch (e) {
      // ignore: avoid_print
      print("Error is $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getTrendingNews() async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          '$baseURL/v1/search?q="$dateToday"&lang=en',
        ),
        headers: {
          host: hostKey,
          api: apiKey,
        },
      );

      final data = jsonDecode(response.body)["articles"];
      // print(data);
      final List<Map<String, dynamic>> newsList =
          List<Map<String, dynamic>>.from(
        data.map((e) => e),
      );
      return newsList;
    } catch (e) {
      // ignore: avoid_print
      print("Error is $e");
      rethrow;
    }
  }
}
