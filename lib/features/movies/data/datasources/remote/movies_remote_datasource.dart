import 'package:moviex/features/movies/data/model/cast_dto.dart';
import 'package:moviex/features/movies/data/model/movies_details_dto.dart';
import 'package:moviex/features/movies/data/model/video_dto.dart';

import '../../model/movie_result.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieDto>> getPlayingNow();

  Future<List<MovieDto>> getAllPopularMovies();

  Future<List<MovieDto>> getAllNowPlayingMovies(int page);

  Future<List<MovieDto>> getTrending();

  Future<MovieDetailDto> getMoviesDetails(int movieId);

  Future<List<VideoDto>> getVideos(int movieId);

  Future<List<CastDto>> getCast(int movieId);

  Future<List<MovieDto>> getSimilar(int movieId);

    Future<List<MovieDto>> getSearched(String movieId);
}
