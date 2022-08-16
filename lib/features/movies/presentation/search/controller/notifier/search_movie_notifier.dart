import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/movie_repository.dart';
import '../state/search_state.dart';

class SearchMovie extends StateNotifier<SearchMoviesState> {
  final MovieRepository _movieRepository;
  final String movies;

  SearchMovie(
    this.movies,
    this._movieRepository,
  ) : super(const SearchMoviesState.initial()) {
    searchMovies(movies);
  }

  Future<void> searchMovies(String movies) async {
    state = const SearchMoviesState.loading();

    var result = await _movieRepository.getSearchedMovies(movies);

    return result.fold(
      (l) => SearchMoviesState.error(error: l),
      (r) {
        if (r.isEmpty) return const SearchMoviesState.empty(movies: []);
        print("Hello ${r[0].title}");
        SearchMoviesState.loaded(movies: r);
      },
    );
  }
}
