part of 'now_playing_movie_bloc.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

// empty state
class NowPlayingEmpty extends NowPlayingMovieState {}

// Loading state
class NowPlayingLoading extends NowPlayingMovieState {}

// Error state
class NowPlayingError extends NowPlayingMovieState {
  final String message;

  NowPlayingError(this.message);
  @override
  List<Object> get props => [message];
}

// Loaded state
class NowPlayingLoaded extends NowPlayingMovieState {
  final List<Movie> nowPlayingMovies;

  NowPlayingLoaded(this.nowPlayingMovies);
  @override
  List<Object> get props => [nowPlayingMovies];
}
