import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/movie_repository.dart';
import '../states/check_bookmark_state.dart';

class CheckBookmarked extends StateNotifier<CheckMovieState> {
  final MovieRepository? _movieRepository;

  CheckBookmarked(
    this._movieRepository,
  ) : super(const CheckMovieState.initial());

  Future<void> checkBookmarked({required int moviesId}) async {
    state = const CheckMovieState.loading();

    var result = await _movieRepository!.checkIfMovieBookmarked(moviesId);
    print(result);
    result.fold(
      (l) => CheckMovieState.error(error: l),
      (r) => CheckMovieState.loaded(checkBookmarked: r),
    );
  }
}
