import 'package:moviex/features/movies/data/model/movies_details_dto.dart';

import '../../../../../core/api/api_const.dart';
import '../../../../../core/config/baseapi.dart';
import '../../model/movie_result.dart';
import '../../model/movies.dart';
import 'movies_remote_datasource.dart';

class MoviesRemoteDataSourceImp extends BaseApi
    implements MoviesRemoteDataSource {
  String api_key = ApiConstants.API_KEY;

  @override
  Future<List<MovieDto>> getAllNowPlayingMovies(int page) async {
    var data = await get('movie/now_playing', query: {
      'language': 'en-US',
      'api_key': api_key,
    });
    return MoviesResultDto.fromJson(data).movies;
  }

  @override
  Future<List<MovieDto>> getAllPopularMovies() async {
    var data = await get('movie/popular', query: {
      'language': 'en-US',
      'api_key': api_key,
    });
    return MoviesResultDto.fromJson(data).movies;
  }

  @override
  Future<List<MovieDto>> getPlayingNow() async {
    var data = await get('movie/upcoming', query: {
      'language': 'en-US',
      'api_key': api_key,
    });
    return MoviesResultDto.fromJson(data).movies;
  }

  @override
  Future<List<MovieDto>> getTrending() async {
    var data = await get('trending/all/day', query: {
      'api_key': api_key,
    });
    print(data['results']);
    return MoviesResultDto.fromJson(data).movies;
  }

  @override
  Future<MovieDetailDto> getMoviesDetails(int movieId) async {
    var data = await get('movie/$movieId', query: {
      'api_key': api_key,
    });
    print(data['results']);
    return MovieDetailDto.fromJson(data);
  }
}


// /movie/{movie_id}/similar
// discover/movie
