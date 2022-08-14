import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';

import '../../../../core/error/failure.dart';
import '../repositories/movie_repository.dart';

class FetchSearchMovies {
  final MovieRepository movieRepository;

  FetchSearchMovies(this.movieRepository);

  Future<Either<Failure, List<MovieEntity>>> call(Params params) async {
    return await movieRepository.getSearchedMovies(params.movieId);
  }
}

class Params extends Equatable {
  final String movieId;
  const Params({
    required this.movieId,
  });

  @override
  List<Object> get props => [movieId];
}
