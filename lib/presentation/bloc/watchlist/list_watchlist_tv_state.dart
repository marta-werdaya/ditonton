part of 'list_watchlist_tv_bloc.dart';

abstract class ListWatchlistTvState extends Equatable {
  const ListWatchlistTvState();

  @override
  List<Object> get props => [];
}

class TvEmpty extends ListWatchlistTvState {}

class TvLoading extends ListWatchlistTvState {}

class TvError extends ListWatchlistTvState {
  final String message;

  TvError(this.message);
  @override
  List<Object> get props => [message];
}

class TvLoaded extends ListWatchlistTvState {
  final List<Tv> tv;

  TvLoaded(this.tv);
  @override
  List<Object> get props => [tv];
}
