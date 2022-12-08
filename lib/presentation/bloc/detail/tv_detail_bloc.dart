import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
  }) : super(TvDetailEmpty()) {
    on<OnGetTvDetail>((event, emit) async {
      final id = event.id;
      emit(TvDetailLoading());
      final movie = await getTvDetail.execute(id);
      final recomendations = await getTvRecommendations.execute(id);

      movie.fold((failure) {
        emit(TvDetailError(failure.message));
      }, (movieDetail) {
        recomendations.fold((failure) {
          emit(TvDetailError(failure.message));
        }, (recomen) {
          emit(TvDetailLoaded(
            tv: movieDetail,
            tvRecomendation: recomen,
          ));
        });
      });
    });
  }
}
