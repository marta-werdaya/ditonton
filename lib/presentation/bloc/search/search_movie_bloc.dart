import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/search_movies.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;

  SearchMovieBloc({
    required this.searchMovies,
  }) : super(SearchMovieEmpty()) {
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
  }
}
