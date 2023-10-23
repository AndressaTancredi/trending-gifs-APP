class Giphy {
  late String giphyUrl;
  late double giphyHeight;

  Giphy.fromJson(Map<String, dynamic> json) {
    giphyUrl = json['images']['original']['url'];
    giphyHeight = double.parse(json['images']['original']['height']);
  }
}
