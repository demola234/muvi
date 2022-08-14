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

  Bookmarked({
    required this.id,
    required this.title,
    required this.posterPath,
  }) : super(
            id: id,
            title: title,
            posterPath: posterPath,
            backdropPath: '',
            releaseDate: '',
            voteAverage: 0,
            overview: '');

  factory Bookmarked.fromMovieEntity(MovieEntity movieEntity) {
    return Bookmarked(
      id: movieEntity.id,
      title: movieEntity.title,
      posterPath: movieEntity.posterPath,
    );
  }
}
