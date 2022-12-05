part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

// empty state
class PopularMovieEmpty extends PopularMovieState {}

// Loading state
class PopularMovieLoading extends PopularMovieState {}

// Error state
class PopularMovieError extends PopularMovieState {
  final String message;

  PopularMovieError(this.message);
  @override
  List<Object> get props => [message];
}

// Loaded state
class PopularMovieLoaded extends PopularMovieState {
  final List<Movie> popularMovies;

  PopularMovieLoaded(this.popularMovies);
  @override
  List<Object> get props => [popularMovies];
}
