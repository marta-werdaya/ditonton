part of 'list_watchlist_movie_bloc.dart';

abstract class ListWatchlistMovieEvent extends Equatable {
  const ListWatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchListMovie extends ListWatchlistMovieEvent {}
