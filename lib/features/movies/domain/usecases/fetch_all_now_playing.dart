import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../entities/movies_result.dart';
import '../repositories/movie_repository.dart';

 class FetchAllPlayNowMovie {
  final MovieRepository movieRepository;

  FetchAllPlayNowMovie(this.movieRepository);
  
  Future<Either<Failure, List<MovieEntity>>> call(Params params) async {
    return await movieRepository.getAllNowPlayingMovies(params.page);
  }

}

class Params extends Equatable {
  final int page;
  const Params({
    required this.page,
  });

  @override
  List<Object> get props => [page];
}
