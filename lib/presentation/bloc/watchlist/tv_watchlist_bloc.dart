import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_watch_list_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watch_list_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_detail.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchListStatusTv getWatchListStatusTv;
  final RemoveWatchlistTv removeWatchlistTv;
  final SaveWatchlistTv saveWatchlistTv;
  TvWatchlistBloc({
    required this.getWatchListStatusTv,
    required this.removeWatchlistTv,
    required this.saveWatchlistTv,
  }) : super(TvWatchlistInitial()) {
    on<OnGetWatchListStatusTv>((event, emit) async {
      emit(TvWatchlistLoading());
      final status = await getWatchListStatusTv.execute(event.id);
      emit(TvWatchlistLoaded(
          status: status,
          message:
              status == true ? 'Remove From Watchlist' : 'Added To Watclist'));
    });

    on<OnRemoveWatchListTv>((event, emit) async {
      emit(TvWatchlistLoading());
      final result = await removeWatchlistTv.execute(event.tv);

      await result.fold(
        (failure) async {
          emit(TvWatchlistError(failure.message));
        },
        (successMessage) async {
          emit(TvWatchlistLoaded(message: successMessage, status: false));
        },
      );
    });

    on<OnSaveWatchListTv>((event, emit) async {
      emit(TvWatchlistLoading());
      final result = await saveWatchlistTv.execute(event.tv);

      await result.fold(
        (failure) async {
          emit(TvWatchlistError(failure.message));
        },
        (successMessage) async {
          emit(TvWatchlistLoaded(message: successMessage, status: true));
        },
      );
    });
  }
}
