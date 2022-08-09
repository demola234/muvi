import 'package:moviex/core/usecases/usecases.dart';

import '../../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/movies_result.dart';

abstract class FetchPopularMovies
    implements UseCase<List<MovieEntity>, NoParams> {
  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParams params);
}
