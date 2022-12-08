part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnGetWatchListStatusTv extends TvWatchlistEvent {
  final int id;

  OnGetWatchListStatusTv(this.id);

  @override
  List<Object> get props => [id];
}

class OnRemoveWatchListTv extends TvWatchlistEvent {
  final TvDetail tv;

  OnRemoveWatchListTv(this.tv);

  @override
  List<Object> get props => [tv];
}

class OnSaveWatchListTv extends TvWatchlistEvent {
  final TvDetail tv;

  OnSaveWatchListTv(this.tv);

  @override
  List<Object> get props => [tv];
}
