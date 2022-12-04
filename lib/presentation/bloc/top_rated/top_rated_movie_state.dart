part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

// empty state
class TopRatedMovieEmpty extends TopRatedMovieState {}

// Loading state
class TopRatedMovieLoading extends TopRatedMovieState {}

// Error state
class TopRatedMovieError extends TopRatedMovieState {
  final String message;

  TopRatedMovieError(this.message);
  @override
  List<Object> get props => [message];
}

// Loaded state
class TopRatedMovieLoaded extends TopRatedMovieState {
  final List<Movie> topRatedMovies;

  TopRatedMovieLoaded(this.topRatedMovies);
  @override
  List<Object> get props => [topRatedMovies];
}
