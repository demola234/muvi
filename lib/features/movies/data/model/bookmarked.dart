import 'package:hive/hive.dart';

import '../../domain/entities/movies_result.dart';

part 'bookmarked.g.dart';

@HiveType(typeId: 0)
class Bookmarked extends MovieEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String posterPath;

  @HiveField(3)
  final String overview;

  Bookmarked({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  }) : super(
            id: id,
            title: title,
            posterPath: posterPath,
            voteAverage: 0,
            releaseDate: "",
            backdropPath: "",
            overview: overview);

  factory Bookmarked.fromMovieEntity(MovieEntity movieEntity) {
    return Bookmarked(
      id: movieEntity.id,
      title: movieEntity.title,
      overview: movieEntity.overview!,
      posterPath: movieEntity.posterPath,
    );
  }
}
