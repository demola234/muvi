import 'package:moviex/features/movies/domain/entities/movies_result.dart';


class MovieDto extends MovieEntity {
  final int id;
  final bool? video;
  final int? voteCount;
  final double? voteAverage;
  final String title;
  final String? releaseDate;
  final String? originalLanguage;
  final String? originalTitle;
  final List<int>? genreIds;
  final String backdropPath;
  final bool? adult;
  final String? overview;
  final String posterPath;
  final double? popularity;
  final String? mediaType;

  const MovieDto({
    required this.id,
    this.video,
    this.voteCount,
    this.voteAverage,
    required this.title,
    this.releaseDate,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    required this.backdropPath,
    this.adult,
    this.overview,
    required this.posterPath,
    this.popularity,
    this.mediaType,
  }) : super(
          id: id,
          title: title,
          backdropPath: backdropPath,
          posterPath: posterPath,
          releaseDate: releaseDate,
          voteAverage: voteAverage,
          overview: overview,
        );

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
      popularity: json['popularity']?.toDouble() ?? 0.0,
      voteCount: json['vote_count'],
      video: json['video'],
      posterPath: json['poster_path'] ?? '',
      id: json['id'] ?? -1,
      adult: json['adult'],
      backdropPath: json['backdrop_path'] ?? '',
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      genreIds: json['genre_ids'].cast<int>(),
      title: json['title'] ?? '',
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      overview: json['overview'],
      releaseDate: json['release_date'],
      mediaType: json['media_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['video'] = video;
    data['vote_count'] = voteCount;
    data['vote_average'] = voteAverage;
    data['title'] = title;
    data['release_date'] = releaseDate;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['genre_ids'] = genreIds;
    data['backdrop_path'] = backdropPath;
    data['adult'] = adult;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['popularity'] = popularity;
    data['media_type'] = mediaType;
    return data;
  }
}