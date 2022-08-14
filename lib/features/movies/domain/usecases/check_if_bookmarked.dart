import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../repositories/movie_repository.dart';

class CheckBookmark {
  final MovieRepository movieRepository;

  CheckBookmark(this.movieRepository);

  Future<Either<Failure, void>> call(Params params) async {
    return await movieRepository.checkIfMovieBookmarked(params.movieId);
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
