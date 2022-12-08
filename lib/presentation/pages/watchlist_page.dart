import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/watchlist/list_watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/list_watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
        ..read<ListWatchlistMovieBloc>().add(FetchWatchListMovie())
        ..read<ListWatchlistTvBloc>().add(FetchWatchListTv());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context
      ..read<ListWatchlistMovieBloc>().add(FetchWatchListMovie())
      ..read<ListWatchlistTvBloc>().add(FetchWatchListTv());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Watchlist'),
            bottom: TabBar(
              unselectedLabelColor: kDavysGrey,
              indicatorColor: kMikadoYellow,
              tabs: [
                Tab(
                  text: 'Movie',
                ),
                Tab(
                  text: 'TV',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              MovieWatchList(),
              TvWatchList(),
            ],
          )),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class MovieWatchList extends StatefulWidget {
  const MovieWatchList({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieWatchList> createState() => _MovieWatchListState();
}

class _MovieWatchListState extends State<MovieWatchList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ListWatchlistMovieBloc, ListWatchlistMovieState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard<Movie>(movie);
              },
              itemCount: state.movies.length,
            );
          } else if (state is Empty) {
            return Center(
              child: Text('List Masih Kosong'),
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text((state as Error).message),
            );
          }
        },
      ),
    );
  }
}

class TvWatchList extends StatefulWidget {
  const TvWatchList({
    Key? key,
  }) : super(key: key);

  @override
  State<TvWatchList> createState() => _TvWatchListState();
}

class _TvWatchListState extends State<TvWatchList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ListWatchlistTvBloc, ListWatchlistTvState>(
        builder: (context, state) {
          if (state is TvLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.tv[index];
                return MovieCard<Tv>(tv);
              },
              itemCount: state.tv.length,
            );
          } else if (state is TvEmpty) {
            return Center(
              child: Text('List Masih Kosong'),
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text((state as TvError).message),
            );
          }
        },
      ),
    );
  }
}
