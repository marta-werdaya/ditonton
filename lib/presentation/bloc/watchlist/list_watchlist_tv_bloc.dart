import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'list_watchlist_tv_event.dart';
part 'list_watchlist_tv_state.dart';

class ListWatchlistTvBloc
    extends Bloc<ListWatchlistTvEvent, ListWatchlistTvState> {
  GetWatchlistTv getWatchlistTv;
  ListWatchlistTvBloc(this.getWatchlistTv) : super(TvEmpty()) {
    on<FetchWatchListTv>((event, emit) async {
      emit(TvLoading());
      final result = await getWatchlistTv.execute();
      result.fold((failure) {
        emit(TvError(failure.message));
      }, (movies) {
        if (movies.isEmpty) {
          emit(TvEmpty());
        } else {
          emit(TvLoaded(movies));
        }
      });
    });
  }
}
