import '../models/gif.dart';

abstract class TrendingGifsState {}

class InitialTrendingGifsState extends TrendingGifsState {
  final List<Gif> gifsList;
  InitialTrendingGifsState({required this.gifsList});
}

class LoadingTrendingGifsState extends TrendingGifsState {}

class LoadedTrendingGifsState extends TrendingGifsState {
  final List<Gif> searchedGifsList;
  LoadedTrendingGifsState({required this.searchedGifsList});
}

class ErrorTrendingGifsState extends TrendingGifsState {}
