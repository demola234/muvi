import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';

import '../../../../../../core/error/failure.dart';

part 'search_state.freezed.dart';

@freezed
class SearchMoviesState with _$SearchMoviesState {
  const factory SearchMoviesState.initial() = _Initial;
  const factory SearchMoviesState.loading() = _Loading;
  const factory SearchMoviesState.loaded({required List<MovieEntity> movies}) =
      _Loaded;
  const factory SearchMoviesState.empty({required List<MovieEntity> movies}) =
      _Empty;
  const factory SearchMoviesState.error({required Failure error}) = _Error;
}
