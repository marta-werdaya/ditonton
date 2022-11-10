import 'package:equatable/equatable.dart';

import '../../domain/entities/tv.dart';

class TvModel extends Equatable {
  TvModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.posterPath,
  });

  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String? posterPath;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_title": originalTitle,
        "poster_path": posterPath,
      };

  Tv toEntity() {
    return Tv(
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      originalName: this.originalTitle,
      posterPath: this.posterPath!,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        originalTitle,
        posterPath,
      ];
}
