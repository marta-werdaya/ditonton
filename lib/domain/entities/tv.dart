import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.posterPath,
    required this.overview,
  });

  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalName;
  final String posterPath;
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
