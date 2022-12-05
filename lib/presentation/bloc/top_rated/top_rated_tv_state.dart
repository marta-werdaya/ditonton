part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

// empty state
class TopRatedTvEmpty extends TopRatedTvState {}

// Loading state
class TopRatedTvLoading extends TopRatedTvState {}

// Error state
class TopRatedTvError extends TopRatedTvState {
  final String message;

  TopRatedTvError(this.message);
  @override
  List<Object> get props => [message];
}

// Loaded state
class TopRatedTvLoaded extends TopRatedTvState {
  final List<Tv> topRatedTvs;

  TopRatedTvLoaded(this.topRatedTvs);
  @override
  List<Object> get props => [topRatedTvs];
}
