part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();
}

class OnSearchMovie extends SearchMovieEvent {
  final String query;

  OnSearchMovie({required this.query});

  @override
  List<Object> get props => [query];
}
