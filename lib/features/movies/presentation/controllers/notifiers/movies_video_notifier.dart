import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviex/features/movies/presentation/controllers/states/video_state.dart';

import '../../../domain/repositories/movie_repository.dart';

class MovieVideoNotifier extends StateNotifier<VideoState> {
  final int movieId;
  final MovieRepository? _movieRepository;

  MovieVideoNotifier(
    this.movieId,
    this._movieRepository,
  ) : super(const VideoState.initial()) {
    getVideos(movieId);
  }

  Future<void> getVideos(int movieId) async {
    state = const VideoState.loading();

    var result = await _movieRepository!.getVideos(movieId);

    state = result.fold(
      (l) => VideoState.error(error: l),
      (r) {
        if (r.isEmpty) return const VideoState.empty(movies: []);
        return VideoState.loaded(movies: r);
      },
    );
  }
}
