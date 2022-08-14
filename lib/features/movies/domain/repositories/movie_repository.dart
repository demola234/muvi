import 'package:dartz/dartz.dart';
import 'package:moviex/features/movies/domain/entities/cast_entity.dart';
import 'package:moviex/features/movies/domain/entities/video_details.dart';

import '../../../../core/error/failure.dart';
import '../entities/movie_details_entity.dart';
import '../entities/movies_result.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getPlayingNow();

  Future<Either<Failure, List<MovieEntity>>> getAllPopularMovies();

  Future<Either<Failure, List<MovieEntity>>> getAllNowPlayingMovies(int page);

  Future<Either<Failure, List<MovieEntity>>> getTrending();

  Future<Either<Failure, MovieDetailEntity>> getMoviesDetails(int movieId);

  Future<Either<Failure, List<VideoEntity>>> getVideos(int movieId);

  Future<Either<Failure, List<CastEntity>>> getCast(int movieId);

  Future<Either<Failure, List<MovieEntity>>> getSimilarMovies(int movieId);
}
