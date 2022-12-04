import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_movie_detail.dart';
import '../../domain/usecases/get_watchlist_status.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
  }) : super(MovieDetailEmpty()) {
    on<OnGetMovieDetail>((event, emit) async {
      final id = event.id;
      emit(MovieDetailLoading());
      final movie = await getMovieDetail.execute(id);
      final recomendations = await getMovieRecommendations.execute(id);

      movie.fold((failure) {
        emit(MovieDetailError(failure.message));
      }, (movieDetail) {
        emit(MovieRecomendationLoading());
        recomendations.fold((failure) {
          emit(MovieRecomendationError(failure.message));
        }, (recomen) {
          emit(MovieDetailLoaded(
            movie: movieDetail,
            movieRecomendation: recomen,
          ));
        });
      });
    });

    on<OnLoadWatchListStatus>((event, emit) async {
      final status = await getWatchListStatus.execute(event.id);
      emit(IsAddedToWatchlist(status));
    });
  }
}
