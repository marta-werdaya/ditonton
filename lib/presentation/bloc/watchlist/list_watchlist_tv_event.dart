part of 'list_watchlist_tv_bloc.dart';

abstract class ListWatchlistTvEvent extends Equatable {
  const ListWatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchListTv extends ListWatchlistTvEvent {}
