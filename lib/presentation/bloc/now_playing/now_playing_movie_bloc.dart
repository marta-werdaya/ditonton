import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMovieBloc(this.getNowPlayingMovies) : super(NowPlayingEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingLoading());

      final result = await getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(NowPlayingError(failure.message));
      }, (movies) {
        emit(NowPlayingLoaded(movies));
      });
    });
  }
}
