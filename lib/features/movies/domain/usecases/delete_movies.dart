import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../repositories/movie_repository.dart';

class DeleteBookmarkedMovie {
  final MovieRepository movieRepository;

  DeleteBookmarkedMovie(this.movieRepository);

  Future<Either<Failure, void>> call(Params params) async {
    return await movieRepository.deleteBookmarkedMovie(params.movieId);
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
