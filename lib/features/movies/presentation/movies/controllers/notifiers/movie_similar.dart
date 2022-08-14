import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/movie_repository.dart';
import '../states/movie_similar_state.dart';

class MovieSimilarNotifier extends StateNotifier<MovieSimilarState> {
  final MovieRepository? _movieRepository;
  final int movieId;

  MovieSimilarNotifier(
    this._movieRepository,
    this.movieId,
  ) : super(const MovieSimilarState.initial()) {
    getSimilarMovies(movieId);
  }

  Future<void> getSimilarMovies(int movieId) async {
    state = const MovieSimilarState.loading();
    var result = await _movieRepository!.getSimilarMovies(movieId);

    state = result.fold(
      (l) => MovieSimilarState.error(error: l),
      (r) {
        if (r.isEmpty) return const MovieSimilarState.empty(movies: []);
        return MovieSimilarState.loaded(movies: r);
      },
    );
  }
}
