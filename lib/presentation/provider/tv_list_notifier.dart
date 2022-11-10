import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:flutter/material.dart';

import '../../common/state_enum.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTv = <Tv>[];
  List<Tv> get nowPlayingTv => _nowPlayingTv;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getNowPlayingTv,
  });

  final GetNowPlayingTv getNowPlayingTv;

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
}
