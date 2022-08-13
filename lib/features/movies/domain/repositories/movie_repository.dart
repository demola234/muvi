import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/movie_details_entity.dart';
import '../entities/movies_result.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getPlayingNow();

  Future<Either<Failure, List<MovieEntity>>> getAllPopularMovies();

  Future<Either<Failure, List<MovieEntity>>> getAllNowPlayingMovies(int page);

  Future<Either<Failure, List<MovieEntity>>> getTrending();

  Future<Either<Failure, MovieDetailEntity>> getMoviesDetails(int movieId);
}
