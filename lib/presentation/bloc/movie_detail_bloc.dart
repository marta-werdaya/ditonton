import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _movieDetail;

  MovieDetailBloc(this._movieDetail) : super(MovieDetailEmpty()) {
    on<OnGetMovieDetail>((event, emit) async {
      final id = event.id;
      emit(MovieDetailLoading());

      final result = await _movieDetail.execute(id);

      result.fold((failure) {
        emit(MovieDetailError(failure.message));
      }, (data) {
        emit(MovieDetailLoaded(data));
      });
    });
  }
}
