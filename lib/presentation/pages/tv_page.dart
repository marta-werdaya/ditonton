import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/now_playing/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/popular/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/pages/now_playing_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/build_subheading.dart';
import '../widgets/poster_list.dart';

class TvPage extends StatefulWidget {
  const TvPage({super.key});
  static const ROUTE_NAME = '/tvpage';

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
        ..read<TopRatedTvBloc>().add(FetchTopRatedTvs())
        ..read<NowPlayingTvBloc>().add(FetchNowPlayingTvs())
        ..read<PopularTvBloc>().add(FetchPopularTvs());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage.tv(),
                ),
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc, PopularTvState>(
                  builder: (context, state) {
                if (state is PopularTvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvLoaded) {
                  return PosterList<Tv>(state.popularTvs);
                } else {
                  return Text('gagal dimuat');
                }
              }),
              BuildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, NowPlayingTvPage.ROUTE_NAME),
              ),
              BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
                  builder: (context, state) {
                if (state is NowPlayingTvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingTvLoaded) {
                  return PosterList<Tv>(state.nowPlayingTvs);
                } else {
                  return Text('gagal dimuat');
                }
              }),
              BuildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                  builder: (context, state) {
                if (state is TopRatedTvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvLoaded) {
                  return PosterList<Tv>(state.topRatedTvs);
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
