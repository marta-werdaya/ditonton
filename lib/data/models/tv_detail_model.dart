import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  TvDetailResponse({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.status,
    required this.name,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.seasons,
    required this.numberOfSeason,
    required this.numberOfEpisode,
  });

  final String? backdropPath;
  final List<GenreModel> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String status;
  final String name;
  final int runtime;
  final double voteAverage;
  final int voteCount;
  final List<SeasonModel> seasons;
  final int numberOfSeason;
  final int numberOfEpisode;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        status: json["status"],
        name: json["name"],
        runtime:
            json["episode_run_time"].isEmpty ? 0 : json["episode_run_time"][0],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        seasons: List<SeasonModel>.from(
            json['seasons'].map((x) => SeasonModel.fromJson(x))),
        numberOfSeason: json["number_of_seasons"] ?? 0,
        numberOfEpisode: json["number_of_episodes"] ?? 0,
      );

  TvDetail toEntity() {
    return TvDetail(
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      name: this.name,
      runtime: this.runtime,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      seasons: this.seasons.map((season) => season.toEntity()).toList(),
      numberOfSeason: this.numberOfSeason,
      numberOfEpisode: this.numberOfEpisode,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        name,
        runtime,
        voteAverage,
        voteCount,
        seasons,
        status,
        numberOfSeason,
        numberOfEpisode,
      ];
}
