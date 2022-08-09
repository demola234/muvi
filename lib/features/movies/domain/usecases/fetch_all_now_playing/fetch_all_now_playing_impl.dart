import 'package:moviex/core/usecases/usecases.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';
import 'package:moviex/features/movies/domain/usecases/fetch_all_now_playing/fetch_all_now_playing.dart';

import '../../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class FetchAllPlayNowMovies
    implements UseCase<List<MovieEntity>, Params> {
  @override
  Future<Either<Failure, List<MovieEntity>>> call(Params params);
}
