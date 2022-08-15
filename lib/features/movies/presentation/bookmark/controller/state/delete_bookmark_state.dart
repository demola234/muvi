import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';

import '../../../../../../core/error/failure.dart';

part 'delete_bookmark_state.freezed.dart';

@freezed
class DeleteBookmarkState with _$DeleteBookmarkState {
  const factory DeleteBookmarkState.initial() = _Initial;
  const factory DeleteBookmarkState.loading() = _Loading;
  const factory DeleteBookmarkState.loaded() =
      _Loaded;
  const factory DeleteBookmarkState.empty() =
      _Empty;
  const factory DeleteBookmarkState.error({required Failure error}) = _Error;
}
