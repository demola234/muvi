import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviex/features/movies/domain/entities/cast_entity.dart';

import '../../../../core/error/failure.dart';
import '../repositories/movie_repository.dart';

class FetchCast {
  final MovieRepository movieRepository;

  FetchCast(this.movieRepository);

  Future<Either<Failure, List<CastEntity>>> call(Params params) async {
    return await movieRepository.getCast(params.movieId);
  }
}

class Params extends Equatable {
  final int movieId;
  const Params({
    required this.movieId,
  });

  @override
  List<Object> get props => [movieId];
}
