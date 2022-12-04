part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

// Movie
class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movie;
  final List<Movie> movieRecomendation;
  // final bool isAddedToWatchlistStatus;

  MovieDetailLoaded({
    required this.movie,
    required this.movieRecomendation,
    // required this.isAddedToWatchlistStatus,
  });

  @override
  List<Object> get props => [
        movie,
        movieRecomendation,
        // isAddedToWatchlistStatus,
      ];
}

// Movie recomendation
class MovieRecomendationLoading extends MovieDetailState {}

class MovieRecomendationError extends MovieDetailState {
  final String message;

  MovieRecomendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecomendationLoaded extends MovieDetailState {
  final List<Movie> movies;

  MovieRecomendationLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

// watchlist
class IsAddedToWatchlist extends MovieDetailState {
  final bool status;

  IsAddedToWatchlist(this.status);

  @override
  List<Object> get props => [status];
}
