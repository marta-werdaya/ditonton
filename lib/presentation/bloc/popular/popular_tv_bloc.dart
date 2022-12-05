import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  GetPopularTv getPopularTv;
  PopularTvBloc(this.getPopularTv) : super(PopularTvEmpty()) {
    on<FetchPopularTvs>((event, emit) async {
      emit(PopularTvLoading());

      final result = await getPopularTv.execute();

      result.fold((failure) {
        emit(PopularTvError(failure.message));
      }, (tvs) {
        emit(PopularTvLoaded(tvs));
      });
    });
  }
}
