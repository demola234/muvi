import 'package:moviex/features/movies/data/model/cast_dto.dart';
import 'package:moviex/features/movies/data/model/cast_result.dart';
import 'package:moviex/features/movies/data/model/movies_details_dto.dart';
import 'package:moviex/features/movies/data/model/video_dto.dart';
import 'package:moviex/features/movies/data/model/video_result.dart';

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
    print(data);
    return MovieDetailDto.fromJson(data);
  }

  @override
  Future<List<VideoDto>> getVideos(int movieId) async {
    var data = await get('movie/$movieId/videos', query: {
      'language': 'en-US',
      'api_key': api_key,
    });
    return VideoResultDto.fromJson(data).videos;
  }

  @override
  Future<List<CastDto>> getCast(int movieId) async {
    var data = await get('movie/$movieId/credits', query: {
      'language': 'en-US',
      'api_key': api_key,
    });
    return CastCrewResultDto.fromJson(data).cast;
  }

  @override
  Future<List<MovieDto>> getSimilar(int movieId) async {
    var data = await get('movie/$movieId/similar', query: {
      'language': 'en-US',
      'api_key': api_key,
    });
    return MoviesResultDto.fromJson(data).movies;
  }

  @override
  Future<List<MovieDto>> getSearched(String searchedMovie) async {
    var data = await get('search/movie', query: {
      'api_key': api_key,
      'query': searchedMovie,
    });
    return MoviesResultDto.fromJson(data).movies;
  }
}
