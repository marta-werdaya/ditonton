import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvNotifier>(context, listen: false)
          .fetchWatchlistTv();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv();
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
                  // icon: Icon(Icons.movie),
                ),
                Tab(
                  text: 'TV',
                  // icon: Icon(Icons.tv),
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
      child: Consumer<WatchlistMovieNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = data.watchlistMovies[index];
                return MovieCard<Movie>(movie);
              },
              itemCount: data.watchlistMovies.length,
            );
          } else if (data.watchlistState == RequestState.Empty) {
            return Center(
              child: Text('List Masih Kosong'),
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(data.message),
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
      child: Consumer<WatchlistTvNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = data.watchlistTv[index];
                return MovieCard<Tv>(tv);
              },
              itemCount: data.watchlistTv.length,
            );
          } else if (data.watchlistState == RequestState.Empty) {
            return Center(
              child: Text('List Masih Kosong'),
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
