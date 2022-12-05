import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  GetNowPlayingTv getNowPlayingTv;
  NowPlayingTvBloc(this.getNowPlayingTv) : super(NowPlayingEmpty()) {
    on<FetchNowPlayingTvs>((event, emit) async {
      emit(NowPlayingLoading());

      final result = await getNowPlayingTv.execute();

      result.fold((failure) {
        emit(NowPlayingTvError(failure.message));
      }, (tvs) {
        emit(NowPlayingLoaded(tvs));
      });
    });
  }
}
