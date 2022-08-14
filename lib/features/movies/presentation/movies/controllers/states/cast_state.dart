import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviex/features/movies/domain/entities/cast_entity.dart';

import '../../../../../../core/error/failure.dart';

part 'cast_state.freezed.dart';

@freezed
class CastState with _$CastState {
  const factory CastState.initial() = _Initial;
  const factory CastState.loading() = _Loading;
  const factory CastState.loaded({required List<CastEntity> movies}) = _Loaded;
  const factory CastState.empty({required List<CastEntity> movies}) = _Empty;
  const factory CastState.error({required Failure error}) = _Error;
}
