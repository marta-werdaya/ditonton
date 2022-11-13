import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? name;
  String? originalName;
  String? posterPath;
  String? overview;

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        originalName,
        posterPath,
        overview,
      ];
}
