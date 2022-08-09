import 'package:moviex/core/usecases/usecases.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';
import 'package:moviex/features/movies/domain/repositories/movie_repository.dart';

import '../../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class FetchPlayNowMoviesImp
    implements UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository movieRepository;

  FetchPlayNowMoviesImp(this.movieRepository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParams params) async {
    return await movieRepository.getPlayingNow();
  }
}