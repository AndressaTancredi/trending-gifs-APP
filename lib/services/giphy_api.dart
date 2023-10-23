import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:trendinggifs/models/giphy.dart';

class GiphyAPIException implements Exception {
  final String message;

  GiphyAPIException(this.message);

  @override
  String toString() {
    return 'GiphyAPIException: $message';
  }
}

class GiphyAPI {
  static Future<List<Giphy>> _fetchGiphyData(
      String endpoint, Map<String, String> queryParams) async {
    queryParams['api_key'] = dotenv.env['GIPHY_API_KEY']!;

    final response = await http.get(
      Uri.https('api.giphy.com', endpoint, queryParams),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    final giphyList = (responseBody['data'] as List<dynamic>)
        .map((giphyData) => Giphy.fromJson(giphyData as Map<String, dynamic>))
        .toList();

    if (response.statusCode == 200 && giphyList.isNotEmpty) {
      return giphyList;
    } else {
      throw GiphyAPIException(
          'Failed to fetch data from Giphy API: HTTP ${response.statusCode}');
    }
  }

  static Future<List<Giphy>> getTrendingGifs() async {
    return _fetchGiphyData('/v1/gifs/trending', {});
  }

  static Future<List<Giphy>> searchTrendingGifs(String word) async {
    final queryParams = {'q': word};
    return _fetchGiphyData('/v1/gifs/search', queryParams);
  }
}
