part of 'search_tv_bloc.dart';

abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();

  @override
  List<Object> get props => [];
}

class OnSearchTv extends SearchTvEvent {
  final String query;

  OnSearchTv(this.query);

  @override
  List<Object> get props => [query];
}
