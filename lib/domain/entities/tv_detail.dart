import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.originalName,
    required this.posterPath,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String name;
  final String originalName;
  final String posterPath;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        name,
        originalName,
        posterPath,
      ];
}
