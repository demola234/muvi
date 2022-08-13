
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repositories/movie_repository.dart';
import '../states/movie_state.dart';

class MovieAllNowPlayingNotifier extends StateNotifier<MovieListState> {
  final MovieRepository? _movieRepository;

  MovieAllNowPlayingNotifier(
    this._movieRepository,
  ) : super(const MovieListState.initial()) {
    getAllNowPlayingMovies();
  }

  Future<void> getAllNowPlayingMovies() async {
    state = const MovieListState.loading();
    int path = 1;
    var result = await _movieRepository!.getAllNowPlayingMovies(path);

    state = result.fold(
      (l) => MovieListState.error(error: l),
      (r) {
        if (r.isEmpty) return const MovieListState.empty(movies: []);
        return MovieListState.loaded(movies: r);
      },
    );
  }
}
