class Gif {
  late String gifUrl;
  late double gifHeight;

  Gif.fromJson(Map<String, dynamic> json) {
    gifUrl = json['images']['original']['url'];
    gifHeight = double.parse(json['images']['original']['height']);
  }
}
