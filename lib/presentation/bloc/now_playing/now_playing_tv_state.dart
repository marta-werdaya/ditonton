part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

// empty state
class NowPlayingEmpty extends NowPlayingTvState {}

// Loading state
class NowPlayingLoading extends NowPlayingTvState {}

// Error state
class NowPlayingTvError extends NowPlayingTvState {
  final String message;

  NowPlayingTvError(this.message);
  @override
  List<Object> get props => [message];
}

// Loaded state
class NowPlayingLoaded extends NowPlayingTvState {
  final List<Tv> nowPlayingTvs;

  NowPlayingLoaded(this.nowPlayingTvs);
  @override
  List<Object> get props => [nowPlayingTvs];
}
