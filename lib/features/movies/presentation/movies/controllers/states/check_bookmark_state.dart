import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';

import '../../../../../../core/error/failure.dart';

part 'check_bookmark_state.freezed.dart';

@freezed
class CheckMovieState with _$CheckMovieState {
  const factory CheckMovieState.initial() = _Initial;
  const factory CheckMovieState.loading() = _Loading;
  const factory CheckMovieState.loaded({required bool checkBookmarked}) = _Loaded;
  const factory CheckMovieState.empty() = _Empty;
  const factory CheckMovieState.error({required Failure error}) = _Error;
}
