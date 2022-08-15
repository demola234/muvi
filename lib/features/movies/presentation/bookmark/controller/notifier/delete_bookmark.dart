import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/movie_repository.dart';
import '../state/delete_bookmark_state.dart';

class DeleteBookmark extends StateNotifier<DeleteBookmarkState> {
  final MovieRepository? _movieRepository;
  final int id;

  DeleteBookmark(
    this.id,
    this._movieRepository,
  ) : super(const DeleteBookmarkState.initial()) {
    deleteBookmark(id);
  }

  Future<void> deleteBookmark(int id) async {
    state = const DeleteBookmarkState.loading();

    var result = await _movieRepository!.deleteBookmarkedMovie(id);

    state = result.fold(
      (l) => DeleteBookmarkState.error(error: l),
      (r) {
        return DeleteBookmarkState.loaded();
      },
    );
  }
}
