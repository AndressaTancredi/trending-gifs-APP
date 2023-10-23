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
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0XFFEAEEF3),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'Search by name',
                          style: TextStyle(
                            color: Color(0XFFB4B4BE),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
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
