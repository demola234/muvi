import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviex/features/movies/presentation/controllers/states/cast_state.dart';

import '../../../domain/repositories/movie_repository.dart';

class MovieCastNotifier extends StateNotifier<CastState> {
  final MovieRepository? _movieRepository;
  final int movieId;

  MovieCastNotifier(
    this.movieId,
    this._movieRepository,
  ) : super(const CastState.initial()) {
    getCast(movieId);
  }

  Future<void> getCast(int movieId) async {
    state = const CastState.loading();
    var result = await _movieRepository!.getCast(movieId);

    state = result.fold(
      (l) => CastState.error(error: l),
      (r) {
        if (r.isEmpty) return const CastState.empty(movies: []);
        return CastState.loaded(movies: r);
      },
    );
  }
}
