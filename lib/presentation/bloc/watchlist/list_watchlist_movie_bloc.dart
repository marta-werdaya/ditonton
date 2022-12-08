import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_watchlist_movies.dart';

part 'list_watchlist_movie_event.dart';
part 'list_watchlist_movie_state.dart';

class ListWatchlistMovieBloc
    extends Bloc<ListWatchlistMovieEvent, ListWatchlistMovieState> {
  final GetWatchlistMovies getWatchList;

  ListWatchlistMovieBloc(this.getWatchList) : super(Empty()) {
    on<FetchWatchListMovie>((event, emit) async {
      emit(Loading());
      final result = await getWatchList.execute();
      result.fold((failure) {
        emit(Error(failure.message));
      }, (movies) {
        if (movies.isEmpty) {
          emit(Empty());
        } else {
          emit(Loaded(movies));
        }
      });
    });
  }
}
