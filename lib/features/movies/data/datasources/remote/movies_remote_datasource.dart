import '../../model/movie_result.dart';


abstract class MoviesRemoteDataSource {
  Future<List<MovieDto>> getPlayingNow();

  Future<List<MovieDto>> getAllPopularMovies();

  Future<List<MovieDto>> getAllNowPlayingMovies(int page);

  Future<List<MovieDto>> getTrending();
}
