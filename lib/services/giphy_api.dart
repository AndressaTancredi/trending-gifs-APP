import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trendinggifs/models/giphy.dart';

class GiphyAPI {
  static const String _apiKey = 'GTAtIJ2TlY1HjkuhzlexoiI9SGumh2CA';

  static Future<List<Giphy>> getTrendingGiphys() async {
    final queryParameters = {
      'api_key': _apiKey,
    };

    final response = await http.get(
      Uri.https('api.giphy.com', '/v1/gifs/trending', queryParameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final giphyList = (responseBody['data'] as List<dynamic>)
          .map((giphyData) => Giphy.fromJson(giphyData as Map<String, dynamic>))
          .toList();
      return giphyList;
    } else {
      throw 'Try again';
    }
  }
}
