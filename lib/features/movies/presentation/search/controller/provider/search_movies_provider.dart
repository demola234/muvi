import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/di/di.dart';
import '../../../../domain/repositories/movie_repository.dart';
import '../notifier/search_movie_notifier.dart';
import '../state/search_state.dart';

var movieRepository = sl<MovieRepository>();

final movieSearchProvider =
    StateNotifierProvider.family<SearchMovie, SearchMoviesState, String>(
  (ref, s) => SearchMovie(
    s,
    movieRepository,
  ),
);
