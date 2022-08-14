import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviex/features/movies/domain/entities/video_details.dart';

import '../../../../../../core/error/failure.dart';
part 'video_state.freezed.dart';

@freezed
class VideoState with _$VideoState {
  const factory VideoState.initial() = _Initial;
  const factory VideoState.loading() = _Loading;
  const factory VideoState.loaded({required List<VideoEntity> movies}) =
      _Loaded;
  const factory VideoState.empty({required List<VideoEntity> movies}) =
      _Empty;
  const factory VideoState.error({required Failure error}) = _Error;
}
