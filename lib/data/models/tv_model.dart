import 'package:equatable/equatable.dart';

import '../../domain/entities/tv.dart';

class TvModel extends Equatable {
  TvModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originalName,
    required this.posterPath,
    required this.overview,
  });

  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalName;
  final String name;
  final String? posterPath;
  final String? overview;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
      backdropPath: json["backdrop_path"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      originalName: json["original_name"],
      name: json["name"],
      posterPath: json["poster_path"],
      overview: json['overview']);

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_name": originalName,
        "poster_path": posterPath,
        "name": name,
        "overview": overview,
      };

  Tv toEntity() {
    return Tv(
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      originalName: this.originalName,
      name: this.name,
      posterPath: this.posterPath!,
      overview: this.overview,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        originalName,
        name,
        posterPath,
        overview,
      ];
}
