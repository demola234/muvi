import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';

import '../../../../../../core/error/failure.dart';

part 'movie_state.freezed.dart';

@freezed
class MovieListState with _$MovieListState {
  const factory MovieListState.initial() = _Initial;
  const factory MovieListState.loading() = _Loading;
  const factory MovieListState.loaded({required List<MovieEntity> movies}) =
      _Loaded;
  const factory MovieListState.empty({required List<MovieEntity> movies}) =
      _Empty;
  const factory MovieListState.error({required Failure error}) = _Error;
}
