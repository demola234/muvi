import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String? releaseDate;
  final num? voteAverage;
  final String? backdropPath;
  final String posterPath;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    this.releaseDate,
    required this.voteAverage,
    this.backdropPath,
    required this.posterPath,
  });

  @override
  List<Object> get props => [id];
}
