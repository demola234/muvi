
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/movie_repository.dart';
import '../states/movie_state.dart';

class MoviePlayNowNotifier extends StateNotifier<MovieListState> {
  final MovieRepository? _movieRepository;

  MoviePlayNowNotifier(
    this._movieRepository,
  ) : super(const MovieListState.initial()) {
    getPlayingNow();
  }

  Future<void> getPlayingNow() async {
    state = const MovieListState.loading();

    var result = await _movieRepository!.getPlayingNow();

    state = result.fold(
      (l) => MovieListState.error(error: l),
      (r) {
        if (r.isEmpty) return const MovieListState.empty(movies: []);
        return MovieListState.loaded(movies: r);
      },
    );
  }
}
