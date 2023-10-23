import '../models/giphy.dart';

abstract class TrendingGiphyState {}

class InitialTrendingGiphyState extends TrendingGiphyState {
  final List<Giphy> giphyList;
  InitialTrendingGiphyState({required this.giphyList});
}

class SearchTrendingGiphyState extends TrendingGiphyState {}

class LoadedTrendingGiphyState extends TrendingGiphyState {}

class ErrorTrendingGiphyState extends TrendingGiphyState {}
