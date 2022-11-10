import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
    required this.genreIds,
    required this.id,
    required this.posterPath,
    required this.name,
  });

  final List<int> genreIds;
  final int id;
  final String name;
  final String? posterPath;

  @override
  List<Object?> get props => [
        genreIds,
        id,
        name,
        posterPath,
      ];
}
