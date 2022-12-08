import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchListStatus getWatchListStatus;
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlist saveWatchlist;
  MovieWatchlistBloc({
    required this.getWatchListStatus,
    required this.removeWatchlist,
    required this.saveWatchlist,
  }) : super(MovieWatchlistInitial()) {
    on<OnGetWatchListStatus>((event, emit) async {
      emit(MovieWatchlistLoading());
      final status = await getWatchListStatus.execute(event.id);
      emit(MovieWatchlistLoaded(
          status: status,
          message:
              status == true ? 'Remove From Watclist' : 'Added To Watclist'));
    });

    on<OnRemoveWatchList>((event, emit) async {
      emit(MovieWatchlistLoading());
      final result = await removeWatchlist.execute(event.movie);

      await result.fold(
        (failure) async {
          emit(MovieWatchlistLoaded(message: failure.message, status: true));
        },
        (successMessage) async {
          emit(MovieWatchlistLoaded(message: successMessage, status: false));
        },
      );
    });

    on<OnSaveWatchList>((event, emit) async {
      emit(MovieWatchlistLoading());
      final result = await saveWatchlist.execute(event.movie);

      await result.fold(
        (failure) async {
          emit(MovieWatchlistLoaded(message: failure.message, status: false));
        },
        (successMessage) async {
          emit(MovieWatchlistLoaded(message: successMessage, status: true));
        },
      );
    });
  }
}
