import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/di.dart';
import '../../../../domain/repositories/movie_repository.dart';
import '../notifier/delete_bookmark.dart';
import '../notifier/get_bookmarks.dart';
import '../state/bookmark_state.dart';
import '../state/delete_bookmark_state.dart';

var movieRepository = sl<MovieRepository>();

final movieBookmarkNotifierProvider =
    StateNotifierProvider.autoDispose<GetBookmarked, BookmarkListState>(
  (ref) => GetBookmarked(movieRepository),
);

final deleteBookmarkNotifier =
    StateNotifierProvider.family<DeleteBookmark, DeleteBookmarkState, int>(
  (ref, s) => DeleteBookmark(s, movieRepository),
);
