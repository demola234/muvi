import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';

import '../../../../core/error/failure.dart';
import '../repositories/movie_repository.dart';

class FetchSimilarMovies {
  final MovieRepository movieRepository;

  FetchSimilarMovies(this.movieRepository);

  Future<Either<Failure, List<MovieEntity>>> call(Params params) async {
    return await movieRepository.getSimilarMovies(params.movieId);
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
