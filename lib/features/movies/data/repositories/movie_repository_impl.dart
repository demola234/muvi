import 'package:moviex/core/error/exceptions.dart';
import 'package:moviex/features/movies/data/datasources/local/movie_local_datasource.dart';
import 'package:moviex/features/movies/domain/entities/cast_entity.dart';
import 'package:moviex/features/movies/domain/entities/movie_details_entity.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';
import 'package:moviex/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:moviex/features/movies/domain/entities/video_details.dart';

import '../../domain/repositories/movie_repository.dart';
import '../datasources/remote/movies_remote_datasource.dart';
import '../model/bookmarked.dart';

class MovieRepositoryImp implements MovieRepository {
  final MoviesRemoteDataSource remoteDataSource;
  final MoviesLocalDataSource localDataSource;

  MovieRepositoryImp(this.remoteDataSource, this.localDataSource);

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
  Future<Either<Failure, void>> bookmarkMovie(MovieEntity movieEntity) async {
    try {
      final table = Bookmarked.fromMovieEntity(movieEntity);
      print(table);
      final response = await localDataSource
          .bookMovie(Bookmarked.fromMovieEntity(movieEntity));
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfMovieBookmarked(int movieId) async {
    try {
      final response = await localDataSource.checkIfMovieBookmarked(movieId);
      print(response);
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteBookmarkedMovie(int movieId) async {
    try {
      final response = await localDataSource.deleteBookmarkedMovie(movieId);
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getBookmarkedMovies() async {
    try {
      final response = await localDataSource.getBookmarkedMovies();
      print(response);
      return Right(response);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }
}
