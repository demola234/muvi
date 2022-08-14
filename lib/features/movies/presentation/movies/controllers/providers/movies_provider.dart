import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviex/core/di/di.dart';
import 'package:moviex/features/movies/domain/repositories/movie_repository.dart';

import '../notifiers/movie_all_now_playing_notifier.dart';
import '../notifiers/movie_cast.dart';
import '../notifiers/movie_similar.dart';
import '../notifiers/movies_all_now_playing.dart';
import '../notifiers/movies_all_popular_notifier.dart';
import '../notifiers/movies_detail_notifier.dart';
import '../notifiers/movies_trending_notifier.dart';
import '../notifiers/movies_video_notifier.dart';
import '../states/cast_state.dart';
import '../states/movie_similar_state.dart';
import '../states/movie_state.dart';
import '../states/movies_detail_state.dart';
import '../states/video_state.dart';

var movieRepository = sl<MovieRepository>();

final movieTrendingNotifierProvider =
    StateNotifierProvider<MovieTrendingNotifier, MovieListState>(
  (ref) => MovieTrendingNotifier(movieRepository),
);

final movieAllNowPlayingNotifier =
    StateNotifierProvider<MovieAllNowPlayingNotifier, MovieListState>(
  (ref) => MovieAllNowPlayingNotifier(movieRepository),
);

final movieAllPopularNotifier =
    StateNotifierProvider<MovieAllPopularNotifier, MovieListState>(
  (ref) => MovieAllPopularNotifier(movieRepository),
);

final moviePlayNowNotifier =
    StateNotifierProvider<MoviePlayNowNotifier, MovieListState>(
  (ref) => MoviePlayNowNotifier(movieRepository),
);

final movieDetailsNotifier =
    StateNotifierProvider.family<MoviesDetailsNotifier, MoviesDetailState, int>(
  (ref, s) => MoviesDetailsNotifier(s, movieRepository),
);

final movieVideoNotifier =
    StateNotifierProvider.family<MovieVideoNotifier, VideoState, int>(
  (ref, s) => MovieVideoNotifier(
    s,
    movieRepository,
  ),
);

final movieCastNotifier =
    StateNotifierProvider.family<MovieCastNotifier, CastState, int>(
  (ref, s) => MovieCastNotifier(s, movieRepository),
);

final movieSimilarNotifier =
    StateNotifierProvider.family<MovieSimilarNotifier, MovieSimilarState, int>(
  (ref, s) => MovieSimilarNotifier(movieRepository, s),
);
