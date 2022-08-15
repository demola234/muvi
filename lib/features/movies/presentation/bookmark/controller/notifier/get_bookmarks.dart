import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/movie_repository.dart';
import '../state/bookmark_state.dart';

class GetBookmarked extends StateNotifier<BookmarkListState> {
  final MovieRepository? _movieRepository;

  GetBookmarked(
    this._movieRepository,
  ) : super(const BookmarkListState.initial()) {
    getBookmarks();
  }

  Future<void> getBookmarks() async {
    state = const BookmarkListState.loading();

    var result = await _movieRepository!.getBookmarkedMovies();

    state = result.fold(
      (l) => BookmarkListState.error(error: l),
      (r) {
        if (r.isEmpty) return const BookmarkListState.empty(movies: []);
        return BookmarkListState.loaded(movies: r);
      },
    );
  }
}
