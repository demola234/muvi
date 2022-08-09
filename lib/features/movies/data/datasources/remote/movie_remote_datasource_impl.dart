import 'package:moviex/core/api/api_const.dart';
import 'package:moviex/core/config/baseapi.dart';
import 'package:moviex/features/movies/data/model/movie_result.dart';
import '../../model/movies.dart';
import 'movies_remote_datasource.dart';

class MoviesRemoteDataSourceImp extends BaseApi
    implements MoviesRemoteDataSource {
  String path = ApiConstants.BASE_URL;
  String api_key = ApiConstants.API_KEY;

  @override
  Future<List<MovieDto>> getAllNowPlayingMovies(int page) async {
    var data = await get(path + '/movie/now_playing', query: {
      'language': 'en-US',
      'api_key': api_key,
    });
    return MoviesResultDto.fromJson(data).movies;
  }

  @override
  Future<List<MovieDto>> getAllPopularMovies() async {
    var data = await get(path + '/movie/popular', query: {
      'language': 'en-US',
      'api_key': api_key,
    });
    return MoviesResultDto.fromJson(data).movies;
  }

  @override
  Future<List<MovieDto>> getPlayingNow() async {
    var data = await get(path + '/movie/upcoming', query: {
      'language': 'en-US',
      'api_key': api_key,
    });
    return MoviesResultDto.fromJson(data).movies;
  }

  @override
  Future<List<MovieDto>> getTrending() async {
    var data = await get(path + '/movie/trending/all/day');
    return MoviesResultDto.fromJson(data).movies;
  }
}
