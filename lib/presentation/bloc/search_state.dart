part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

// Movie
class SearchMovieEmpty extends SearchState {}

class SearchMovieLoading extends SearchState {}

class SearchMovieError extends SearchState {
  final String message;

  SearchMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMovieLoaded extends SearchState {
  final List<Movie> result;

  SearchMovieLoaded(this.result);

  @override
  List<Object> get props => [result];
}

// Tv
class SearchTvEmpty extends SearchState {}

class SearchTvLoading extends SearchState {}

class SearchTvError extends SearchState {
  final String message;

  SearchTvError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvLoaded extends SearchState {
  final List<Tv> result;

  SearchTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
