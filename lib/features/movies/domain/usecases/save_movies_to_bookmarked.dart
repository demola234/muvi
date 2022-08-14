import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/movies_result.dart';
import '../repositories/movie_repository.dart';

 class SaveMoviesToBookmarked {
  final MovieRepository movieRepository;

  SaveMoviesToBookmarked(this.movieRepository);
  
  Future<Either<Failure, void>> call(MovieEntity movieEntity) async {
    return await movieRepository.bookmarkMovie(movieEntity);
  }

}

