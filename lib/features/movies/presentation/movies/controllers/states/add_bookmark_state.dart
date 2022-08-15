import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';

import '../../../../../../core/error/failure.dart';

part 'add_bookmark_state.freezed.dart';

@freezed
class AddBookmarkState with _$AddBookmarkState {
  const factory AddBookmarkState.initial() = _Initial;
  const factory AddBookmarkState.loading() = _Loading;
  const factory AddBookmarkState.success({required MovieEntity movies}) = _Loaded;

  const factory AddBookmarkState.error({required Failure error}) = _Error;
}
