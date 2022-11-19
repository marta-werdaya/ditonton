import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.seasons,
    required this.numberOfEpisode,
    required this.numberOfSeason,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String posterPath;
  final int runtime;
  final double voteAverage;
  final int voteCount;
  final List<Season> seasons;
  final int numberOfSeason;
  final int numberOfEpisode;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        name,
        originalName,
        overview,
        posterPath,
        runtime,
        voteAverage,
        voteCount,
        numberOfSeason,
        numberOfEpisode,
      ];
}
