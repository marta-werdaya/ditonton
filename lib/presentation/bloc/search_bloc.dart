import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/search_movies.dart';

part 'search_event.dart';
part 'search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;
  final SearchTv searchTvs;

  SearchBloc({required this.searchMovies, required this.searchTvs})
      : super(SearchMovieEmpty()) {
    on<OnSearchMovie>((event, emit) async {
      final query = event.query;

      emit(SearchMovieLoading());

      final result = await searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchMovieError(failure.message));
        },
        (data) {
          emit(SearchMovieLoaded(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<OnSearchTv>((event, emit) async {
      final query = event.query;

      emit(SearchTvLoading());

      final result = await searchTvs.execute(query);

      result.fold(
        (failure) {
          emit(SearchTvError(failure.message));
        },
        (data) {
          emit(SearchTvLoaded(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
