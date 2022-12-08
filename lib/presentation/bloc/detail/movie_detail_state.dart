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

  MovieDetailLoaded({
    required this.movie,
    required this.movieRecomendation,
  });

  @override
  List<Object> get props => [
        movie,
        movieRecomendation,
        // isAddedToWatchlistStatus,
      ];
}
