import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviex/core/di/di.dart';
import 'package:moviex/features/movies/domain/repositories/movie_repository.dart';
import 'package:moviex/features/movies/presentation/controllers/notifiers/movies_notifier.dart';
import 'package:moviex/features/movies/presentation/controllers/states/movie_state.dart';

var movieRepository = sl<MovieRepository>();

final movieNotifierProvider =
    StateNotifierProvider<MovieNotifier, MovieListState>(
  (ref) => MovieNotifier(movieRepository),
);
