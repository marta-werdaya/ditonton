part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

// Tv
class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailError extends TvDetailState {
  final String message;

  TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailLoaded extends TvDetailState {
  final TvDetail tv;
  final List<Tv> tvRecomendation;

  TvDetailLoaded({
    required this.tv,
    required this.tvRecomendation,
  });

  @override
  List<Object> get props => [
        tv,
        tvRecomendation,
      ];
}
