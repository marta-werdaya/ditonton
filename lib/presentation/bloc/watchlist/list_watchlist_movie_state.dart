part of 'list_watchlist_movie_bloc.dart';

abstract class ListWatchlistMovieState extends Equatable {
  const ListWatchlistMovieState();

  @override
  List<Object> get props => [];
}

class Empty extends ListWatchlistMovieState {}

class Loading extends ListWatchlistMovieState {}

class Error extends ListWatchlistMovieState {
  final String message;

  Error(this.message);
  @override
  List<Object> get props => [message];
}

class Loaded extends ListWatchlistMovieState {
  final List<Movie> movies;

  Loaded(this.movies);
  @override
  List<Object> get props => [movies];
}
