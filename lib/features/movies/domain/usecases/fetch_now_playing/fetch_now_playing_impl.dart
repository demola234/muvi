import 'package:moviex/core/usecases/usecases.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';

import '../../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class FetchPlayNowMovies
    implements UseCase<List<MovieEntity>, NoParams> {
  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParams params);
}
