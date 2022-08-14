import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';

import '../../../../../core/error/failure.dart';

part 'movie_similar_state.freezed.dart';

@freezed
class MovieSimilarState with _$MovieSimilarState {
  const factory MovieSimilarState.initial() = _Initial;
  const factory MovieSimilarState.loading() = _Loading;
  const factory MovieSimilarState.loaded({required List<MovieEntity> movies}) =
      _Loaded;
  const factory MovieSimilarState.empty({required List<MovieEntity> movies}) =
      _Empty;
  const factory MovieSimilarState.error({required Failure error}) = _Error;
}
