import 'movie_result.dart';

class MoviesResultDto {
  late final List<MovieDto> movies;

  MoviesResultDto({required this.movies});

  factory MoviesResultDto.fromJson(Map<String, dynamic> json) {
    var movies = List<MovieDto>.empty(growable: true);
    if (json['results'] != null) {
      json['results'].forEach((v) {
        final movieDto = MovieDto.fromJson(v);
        if (_isValidMovie(movieDto)) {
          movies.add(movieDto);
        }
      });
    }
    return MoviesResultDto(movies: movies);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = movies.map((v) => v.toJson()).toList();
    return data;
  }
}

bool _isValidMovie(MovieDto movieDto) {
  return movieDto.id != -1 &&
      movieDto.title.isNotEmpty &&
      movieDto.backdropPath.isNotEmpty &&
      movieDto.posterPath.isNotEmpty;
}