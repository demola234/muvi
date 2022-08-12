import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviex/features/movies/domain/repositories/movie_repository.dart';

import '../states/movie_state.dart';

class MovieTrendingNotifier extends StateNotifier<MovieListState> {
  final MovieRepository? _movieRepository;

  MovieTrendingNotifier(
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

class MovieAllPopularNotifier extends StateNotifier<MovieListState> {
  final MovieRepository? _movieRepository;

  MovieAllPopularNotifier(
    this._movieRepository,
  ) : super(const MovieListState.initial()) {
    getAllPopularMovies();
  }

  Future<void> getAllPopularMovies() async {
    state = const MovieListState.loading();

    var result = await _movieRepository!.getAllPopularMovies();

    state = result.fold(
      (l) => MovieListState.error(error: l),
      (r) {
        if (r.isEmpty) return const MovieListState.empty(movies: []);
        return MovieListState.loaded(movies: r);
      },
    );
  }
}
