part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnSearchMovie extends SearchEvent {
  final String query;

  OnSearchMovie(this.query);

  @override
  List<Object> get props => [query];
}

class OnSearchTv extends SearchEvent {
  final String query;

  OnSearchTv(this.query);

  @override
  List<Object> get props => [query];
}
