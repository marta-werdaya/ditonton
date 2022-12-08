part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class TvWatchlistInitial extends TvWatchlistState {}

class TvWatchlistLoading extends TvWatchlistState {}

class TvWatchlistError extends TvWatchlistState {
  final String message;

  TvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistLoaded extends TvWatchlistState {
  final bool status;
  final String message;

  TvWatchlistLoaded({required this.status, required this.message});

  @override
  List<Object> get props => [status, message];
}
