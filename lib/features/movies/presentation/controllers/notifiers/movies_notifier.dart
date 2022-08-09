import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/di.dart';
import '../../../domain/usecases/fetch_trending.dart';

var getTrending = sl<FetchTrendingMovies>();

final getSchedulesProvider = FutureProvider.autoDispose((ref) async {
  final profile = getTrending.movieRepository.getTrending();
  print(profile);
  return profile;
});
