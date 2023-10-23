import 'package:bloc/bloc.dart';
import 'package:trendinggifs/cubit/trending_giphy_state.dart';
import 'package:trendinggifs/services/giphy_api.dart';

class TrendingGiphyCubit extends Cubit<TrendingGiphyState> {
  TrendingGiphyCubit() : super(InitialTrendingGiphyState(giphyList: const []));

  Future<void> getGiphys() async {
    try {
      final giphyList = await GiphyAPI.getTrendingGiphys();
      emit(InitialTrendingGiphyState(giphyList: giphyList));
    } catch (e) {
      emit(ErrorTrendingGiphyState());
    }
  }
}
