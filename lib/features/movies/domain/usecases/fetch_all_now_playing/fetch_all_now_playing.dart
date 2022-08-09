import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:moviex/core/usecases/usecases.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';
import 'package:moviex/features/movies/domain/repositories/movie_repository.dart';

import '../../../../../core/error/failure.dart';

abstract class FetchAllPlayNowMoviesImp
    implements UseCase<List<MovieEntity>, Params> {
  final MovieRepository movieRepository;

  FetchAllPlayNowMoviesImp(this.movieRepository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(Params params) async {
    return await movieRepository.getAllNowPlayingMovies(params.page);
  }
}

class Params extends Equatable {
  final int page;
  Params({
    required this.page,
  });

  @override
  List<Object> get props => [page];
}
