import 'package:moviex/core/error/exceptions.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';
import 'package:moviex/core/error/failure.dart';
import 'package:dartz/dartz.dart';

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
}
