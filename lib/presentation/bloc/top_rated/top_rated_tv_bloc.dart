import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/get_top_rated_tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTvs;
  TopRatedTvBloc(this.getTopRatedTvs) : super(TopRatedTvEmpty()) {
    on<FetchTopRatedTvs>((event, emit) async {
      emit(TopRatedTvLoading());

      final result = await getTopRatedTvs.execute();

      result.fold((failure) {
        emit(TopRatedTvError(failure.message));
      }, (tv) {
        emit(TopRatedTvLoaded(tv));
      });
    });
  }
}
