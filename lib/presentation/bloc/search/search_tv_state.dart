part of 'search_tv_bloc.dart';

abstract class SearchTvState extends Equatable {
  const SearchTvState();

  @override
  List<Object> get props => [];
}

// Tv
class SearchTvEmpty extends SearchTvState {}

class SearchTvLoading extends SearchTvState {}

class SearchTvError extends SearchTvState {
  final String message;

  SearchTvError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvLoaded extends SearchTvState {
  final List<Tv> result;

  SearchTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
