import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviex/features/movies/domain/entities/movie_details_entity.dart';

import '../../../../core/error/failure.dart';
import '../repositories/movie_repository.dart';

class FetchMoviesDetails {
  final MovieRepository movieRepository;

  FetchMoviesDetails(this.movieRepository);

  Future<Either<Failure, MovieDetailEntity>> call(Params params) async {
    return await movieRepository.getMoviesDetails(params.movieId);
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
