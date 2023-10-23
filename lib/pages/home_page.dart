import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../cubit/trending_gifs_cubit.dart';
import '../cubit/trending_gifs_state.dart';
import '../models/gif.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _inputController = TextEditingController();
  late final TrendingGifsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TrendingGifsCubit>(context);
    cubit.getGifs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              TextFormField(
                controller: _inputController,
                cursorColor: const Color(0XFFb3bac2),
                onFieldSubmitted: (value) {
                  cubit.searchGifs(_inputController.text);
                  _inputController.clear();
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  prefixIcon: Image.asset(
                    'assets/icons/search.png',
                    scale: 30,
                  ),
                  hintText: 'Search by name',
                  helperStyle: const TextStyle(
                    color: Color(0XFFb3bac2),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  fillColor: const Color(0XFFEAEEF3),
                  filled: true,
                ),
              ),
              Expanded(
                child: BlocBuilder(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is InitialTrendingGifsState) {
                      return _buildGifsList(gifsList: state.gifsList);
                    }
                    if (state is LoadingTrendingGifsState) {
                      return CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.contain,
                        imageUrl:
                            'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMnp4em44emVwcTRhYjgwdmt6Zzh5MGJlYTRndmRoNTkzY2plNHR2cCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/lZfieM3rRK5ZTMOnNd/giphy.gif',
                        height: 300,
                      );
                    }
                    if (state is LoadedTrendingGifsState) {
                      return _buildGifsList(gifsList: state.searchedGifsList);
                    } else if (state is ErrorTrendingGifsState) {
                      return const Center(
                        child: Text(
                            'Sorry, something went wrong. Please try again.'),
                      );
                    } else {
                      return const SizedBox(
                        height: 150.0,
                        width: 150.0,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0XFFEAEEF3),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGifsList({required List<Gif> gifsList}) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: MasonryGridView.builder(
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemCount: gifsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: gifsList[index].gifUrl,
              height: gifsList[index].gifHeight,
              placeholder: (context, url) => const SizedBox(
                height: 50.0,
                width: 50.0,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0XFFEAEEF3),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
