import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';

import '../../../../../../core/error/failure.dart';

part 'bookmark_state.freezed.dart';

@freezed
class BookmarkListState with _$BookmarkListState {
  const factory BookmarkListState.initial() = _Initial;
  const factory BookmarkListState.loading() = _Loading;
  const factory BookmarkListState.loaded({required List<MovieEntity> movies}) =
      _Loaded;
  const factory BookmarkListState.empty({required List<MovieEntity> movies}) =
      _Empty;
  const factory BookmarkListState.error({required Failure error}) = _Error;
}
