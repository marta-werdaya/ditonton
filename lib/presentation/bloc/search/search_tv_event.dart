part of 'search_tv_bloc.dart';

abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();
}

class OnSearchTv extends SearchTvEvent {
  final String query;

  OnSearchTv({required this.query});

  @override
  List<Object> get props => [query];
}
