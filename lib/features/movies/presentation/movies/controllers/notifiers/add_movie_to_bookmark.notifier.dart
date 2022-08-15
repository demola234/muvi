import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/movies_result.dart';
import '../../../../domain/repositories/movie_repository.dart';
import '../states/add_bookmark_state.dart';

class AddMovieToBookmark extends StateNotifier<AddBookmarkState> {
  final MovieRepository? _movieRepository;
  final MovieEntity movieEntity;

  AddMovieToBookmark(
    this._movieRepository,
    this.movieEntity,
  ) : super(const AddBookmarkState.initial());

  Future<void> addMovieToBookmark({required MovieEntity movieEntity}) async {
    state = const AddBookmarkState.loading();

    var result = await _movieRepository!.bookmarkMovie(movieEntity);

    result.fold(
      (l) => AddBookmarkState.error(error: l),
      (r) => AddBookmarkState.success(movies: movieEntity),
    );
  }
}
