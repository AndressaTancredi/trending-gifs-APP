import 'package:bloc/bloc.dart';
import 'package:trendinggifs/cubit/trending_giphy_state.dart';
import 'package:trendinggifs/services/giphy_api.dart';

class TrendingGiphyCubit extends Cubit<TrendingGiphyState> {
  TrendingGiphyCubit() : super(InitialTrendingGiphyState(giphyList: const []));

  Future<void> getGifs() async {
    try {
      emit(LoadingTrendingGiphyState());
      await delay();
      final giphyList = await GiphyAPI.getTrendingGifs();
      emit(InitialTrendingGiphyState(giphyList: giphyList));
    } catch (e) {
      emit(ErrorTrendingGiphyState());
    }
  }

  Future<void> searchGifs(String word) async {
    try {
      emit(LoadingTrendingGiphyState());
      await delay();
      final giphyList = await GiphyAPI.searchTrendingGifs(word);
      emit(LoadedTrendingGiphyState(searchedGiphyList: giphyList));
    } catch (e) {
      emit(ErrorTrendingGiphyState());
    }
  }

  delay() async {
    return await Future.delayed(const Duration(seconds: 3));
  }
}
