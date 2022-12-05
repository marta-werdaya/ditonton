part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

// empty state
class PopularTvEmpty extends PopularTvState {}

// Loading state
class PopularTvLoading extends PopularTvState {}

// Error state
class PopularTvError extends PopularTvState {
  final String message;

  PopularTvError(this.message);
  @override
  List<Object> get props => [message];
}

// Loaded state
class PopularTvLoaded extends PopularTvState {
  final List<Tv> popularTvs;

  PopularTvLoaded(this.popularTvs);
  @override
  List<Object> get props => [popularTvs];
}
