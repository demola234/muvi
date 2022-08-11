import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviex/features/movies/domain/repositories/movie_repository.dart';

import '../states/movie_state.dart';

class MovieNotifier extends StateNotifier<MovieListState> {
  final MovieRepository? _movieRepository;

  MovieNotifier(
    this._movieRepository,
  ) : super(const MovieListState.initial()) {
    getTrending();
  }

  Future<void> getTrending() async {
    state = const MovieListState.loading();

    var result = await _movieRepository!.getTrending();

    state = result.fold(
      (l) => MovieListState.error(error: l),
      (r) {
        if (r.isEmpty) return const MovieListState.empty(movies: []);
        return MovieListState.loaded(movies: r);
      },
    );
  }
}
