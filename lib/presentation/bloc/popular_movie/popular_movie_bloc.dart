import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  GetPopularMovies getPopularMovies;
  PopularMovieBloc(this.getPopularMovies) : super(PopularMovieEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMovieLoading());

      final result = await getPopularMovies.execute();

      result.fold((failure) {
        emit(PopularMovieError(failure.message));
      }, (movies) {
        print(movies);
        emit(PopularMovieLoaded(movies));
      });
    });
  }
}
