

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';
import '../entities/movies_result.dart';
import '../repositories/movie_repository.dart';

 class FetchPlayNowMovies {
  final MovieRepository movieRepository;

  FetchPlayNowMovies(this.movieRepository);
  
  Future<Either<Failure, List<MovieEntity>>> call(NoParams params) async {
    return await movieRepository.getPlayingNow();
  }
}