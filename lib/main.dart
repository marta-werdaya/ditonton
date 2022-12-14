import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/popular/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/popular/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/list_watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/list_watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/now_playing_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'common/http_ssl_pinning.dart';
import 'presentation/pages/popular_tv_page.dart';
import 'presentation/pages/tv_detail_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HttpSSLPinning.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<SearchMovieBloc>(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider<SearchTvBloc>(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider<MovieDetailBloc>(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider<NowPlayingMovieBloc>(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider<PopularMovieBloc>(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider<TopRatedMovieBloc>(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider<TopRatedTvBloc>(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider<NowPlayingTvBloc>(
          create: (_) => di.locator<NowPlayingTvBloc>(),
        ),
        BlocProvider<PopularTvBloc>(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider<ListWatchlistMovieBloc>(
          create: (_) => di.locator<ListWatchlistMovieBloc>(),
        ),
        BlocProvider<ListWatchlistTvBloc>(
          create: (_) => di.locator<ListWatchlistTvBloc>(),
        ),
        BlocProvider<TvDetailBloc>(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (_) => di.locator<TvWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case NowPlayingTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowPlayingTvPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case TvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvPage());
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
