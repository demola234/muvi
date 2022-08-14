import 'package:moviex/core/error/exceptions.dart';
import 'package:moviex/features/movies/domain/entities/cast_entity.dart';
import 'package:moviex/features/movies/domain/entities/movie_details_entity.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';
import 'package:moviex/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:moviex/features/movies/domain/entities/video_details.dart';

import '../../domain/repositories/movie_repository.dart';
import '../datasources/remote/movies_remote_datasource.dart';

class MovieRepositoryImp implements MovieRepository {
  final MoviesRemoteDataSource remoteDataSource;

  MovieRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, List<MovieEntity>>> getAllNowPlayingMovies(
      int page) async {
    try {
      final response = await remoteDataSource.getAllNowPlayingMovies(page);
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getAllPopularMovies() async {
    try {
      final response = await remoteDataSource.getAllPopularMovies();
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getPlayingNow() async {
    try {
      final response = await remoteDataSource.getPlayingNow();
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getTrending() async {
    try {
      final response = await remoteDataSource.getTrending();
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MovieDetailEntity>> getMoviesDetails(
      int movieId) async {
    try {
      final response = await remoteDataSource.getMoviesDetails(movieId);
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getVideos(int movieId) async {
    try {
      final response = await remoteDataSource.getVideos(movieId);
      print(response);
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CastEntity>>> getCast(int movieId) async {
    try {
      final response = await remoteDataSource.getCast(movieId);
      print(response);
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getSimilarMovies(
      int movieId) async {
    try {
      final response = await remoteDataSource.getSimilar(movieId);
      print(response);
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getSearchedMovies(
      String movies) async {
    try {
      final response = await remoteDataSource.getSearched(movies);
      print(response);
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, void>> bookmarkMovie(MovieEntity movieEntity) {
    // TODO: implement bookmarkMovie
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, bool>> checkIfMovieBookmarked(int movieId) {
    // TODO: implement checkIfMovieBookmarked
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> deleteBookmarkedMovie(int movieId) {
    // TODO: implement deleteBookmarkedMovie
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<MovieEntity>>> getBookmarkedMovies() {
    // TODO: implement getBookmarkedMovies
    throw UnimplementedError();
  }
}
