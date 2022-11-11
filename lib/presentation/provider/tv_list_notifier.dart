import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/material.dart';

import '../../common/state_enum.dart';

class TvListNotifier extends ChangeNotifier {
  var _popularTv = <Tv>[];
  List<Tv> get popularTv => _popularTv;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _nowPlayingTv = <Tv>[];
  List<Tv> get nowPlayingTv => _nowPlayingTv;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _topRatedTv = <Tv>[];
  List<Tv> get topRatedTv => _topRatedTv;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getPopularTv,
    required this.getNowPlayingTv,
    required this.getTopRatedTv,
  });

  final GetPopularTv getPopularTv;
  final GetNowPlayingTv getNowPlayingTv;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchNowPlayingTv() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularState = RequestState.Loaded;
        _popularTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedState = RequestState.Loaded;
        _topRatedTv = tvData;
        notifyListeners();
      },
    );
  }
}
