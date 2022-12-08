part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetMovieDetail extends MovieDetailEvent {
  final int id;

  OnGetMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnLoadWatchListStatus extends MovieDetailEvent {
  final int id;

  OnLoadWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}
