import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repositories/movie_repository.dart';
import '../states/movies_detail_state.dart';

class MoviesDetailsNotifier extends StateNotifier<MoviesDetailState> {
  final MovieRepository? _movieRepository;

  MoviesDetailsNotifier(
    this._movieRepository,
  ) : super(const MoviesDetailState.initial());

  Future<void> getMoviesDetails(int moviesId) async {
    state = const MoviesDetailState.loading();

    var result = await _movieRepository!.getMoviesDetails(moviesId);

    state = result.fold(
      (l) => MoviesDetailState.error(error: l),
      (r) {
        return MoviesDetailState.empty(movies: r);
      },
    );
  }
}
