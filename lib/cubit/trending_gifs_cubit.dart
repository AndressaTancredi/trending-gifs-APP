import 'package:bloc/bloc.dart';
import 'package:trending_gifs/cubit/trending_gifs_state.dart';

import '../services/giphy_api.dart';

class TrendingGifsCubit extends Cubit<TrendingGifsState> {
  TrendingGifsCubit() : super(InitialTrendingGifsState(gifsList: const []));

  Future<void> getGifs() async {
    try {
      emit(LoadingTrendingGifsState());
      await delay();
      final gifList = await GiphyAPI.getTrendingGifs();
      emit(InitialTrendingGifsState(gifsList: gifList));
    } catch (e) {
      emit(ErrorTrendingGifsState());
    }
  }

  Future<void> searchGifs(String input) async {
    try {
      emit(LoadingTrendingGifsState());
      await delay();
      final gifList = await GiphyAPI.searchTrendingGifs(input);
      emit(LoadedTrendingGifsState(searchedGifsList: gifList));
    } catch (e) {
      emit(ErrorTrendingGifsState());
    }
  }

  delay() async {
    return await Future.delayed(const Duration(seconds: 3));
  }
}
