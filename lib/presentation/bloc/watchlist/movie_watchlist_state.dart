part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistLoaded extends MovieWatchlistState {
  final bool status;
  final String message;

  MovieWatchlistLoaded({required this.status, required this.message});

  @override
  List<Object> get props => [status, message];
}
