import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/search_tv.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv searchTvs;

  SearchTvBloc({required this.searchTvs}) : super(SearchTvEmpty()) {
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
