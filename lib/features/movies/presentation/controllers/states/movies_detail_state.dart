import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviex/features/movies/domain/entities/movie_details_entity.dart';

import '../../../../../core/error/failure.dart';

part 'movies_detail_state.freezed.dart';

@freezed
class MoviesDetailState with _$MoviesDetailState {
  const factory MoviesDetailState.initial() = _Initial;
  const factory MoviesDetailState.loading() = _Loading;
  const factory MoviesDetailState.loaded({required MovieDetailEntity movies}) =
      _Loaded;
  const factory MoviesDetailState.empty({required MovieDetailEntity movies}) =
      _Empty;
  const factory MoviesDetailState.error({required Failure error}) = _Error;
}
