import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviex/core/di/di.dart';
import 'package:moviex/features/movies/domain/repositories/movie_repository.dart';
import 'package:moviex/features/movies/presentation/controllers/notifiers/movies_trending_notifier.dart';
import 'package:moviex/features/movies/presentation/controllers/states/movie_state.dart';

import '../notifiers/movie_all_now_playing_notifier.dart';
import '../notifiers/movies_all_now_playing.dart';
import '../notifiers/movies_all_popular_notifier.dart';

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
