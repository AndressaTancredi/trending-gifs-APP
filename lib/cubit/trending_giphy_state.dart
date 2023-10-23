import '../models/giphy.dart';

abstract class TrendingGiphyState {}

class InitialTrendingGiphyState extends TrendingGiphyState {
  final List<Giphy> giphyList;
  InitialTrendingGiphyState({required this.giphyList});
}

class LoadingTrendingGiphyState extends TrendingGiphyState {}

class LoadedTrendingGiphyState extends TrendingGiphyState {
  final List<Giphy> searchedGiphyList;
  LoadedTrendingGiphyState({required this.searchedGiphyList});
}

class ErrorTrendingGiphyState extends TrendingGiphyState {}
