import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviex/features/movies/domain/entities/video_details.dart';

import '../../../../core/error/failure.dart';
import '../repositories/movie_repository.dart';

 class FetchVideos {
  final MovieRepository movieRepository;

  FetchVideos(this.movieRepository);
  
  Future<Either<Failure, List<VideoEntity>>> call(Params params) async {
    return await movieRepository.getVideos(params.page);
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
