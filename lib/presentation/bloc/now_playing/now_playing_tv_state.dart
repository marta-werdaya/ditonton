part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

// empty state
class NowPlayingTvEmpty extends NowPlayingTvState {}

// Loading state
class NowPlayingTvLoading extends NowPlayingTvState {}

// Error state
class NowPlayingTvError extends NowPlayingTvState {
  final String message;

  NowPlayingTvError(this.message);
  @override
  List<Object> get props => [message];
}

// Loaded state
class NowPlayingTvLoaded extends NowPlayingTvState {
  final List<Tv> nowPlayingTvs;

  NowPlayingTvLoaded(this.nowPlayingTvs);
  @override
  List<Object> get props => [nowPlayingTvs];
}
