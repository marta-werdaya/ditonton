import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/now_playing/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<NowPlayingTvBloc>().add(FetchNowPlayingTvs()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
          builder: (context, state) {
            if (state is NowPlayingTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTvLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.nowPlayingTvs[index];
                  return MovieCard<Tv>(tv);
                },
                itemCount: state.nowPlayingTvs.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text((state as NowPlayingTvError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
