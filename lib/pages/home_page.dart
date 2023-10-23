import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../cubit/trending_giphy_cubit.dart';
import '../cubit/trending_giphy_state.dart';
import '../models/giphy.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TrendingGiphyCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TrendingGiphyCubit>(context);
    cubit.getGiphys();
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
              TextField(
                onTap: () {},
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
                    if (state is InitialTrendingGiphyState) {
                      return _buildGiphyList(giphyList: state.giphyList);
                    } else if (state is ErrorTrendingGiphyState) {
                      return const Text('An error occurred');
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

  Widget _buildGiphyList({required List<Giphy> giphyList}) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: MasonryGridView.builder(
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemCount: giphyList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: giphyList[index].giphyUrl,
              height: giphyList[index].giphyHeight,
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
