part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnGetWatchListStatus extends MovieWatchlistEvent {
  final int id;

  OnGetWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnRemoveWatchList extends MovieWatchlistEvent {
  final MovieDetail movie;

  OnRemoveWatchList(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnSaveWatchList extends MovieWatchlistEvent {
  final MovieDetail movie;

  OnSaveWatchList(this.movie);

  @override
  List<Object> get props => [movie];
}
