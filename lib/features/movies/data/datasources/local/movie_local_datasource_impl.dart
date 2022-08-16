import 'package:hive/hive.dart';
import 'package:moviex/features/movies/data/datasources/local/movie_local_datasource.dart';
import 'package:moviex/features/movies/data/model/bookmarked.dart';

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  @override
  Future<void> bookMovie(Bookmarked movieTable) async {
    final movieBox = await Hive.openBox('movieBox');
    await movieBox.put(movieTable.id, movieTable);
  }

  @override
  Future<bool> checkIfMovieBookmarked(int movieId) async {
    final movieBox = await Hive.openBox('movieBox');
    if (movieBox.containsKey(movieId)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> deleteBookmarkedMovie(int movieId) async {
    final movieBox = await Hive.openBox('movieBox');
    await movieBox.delete(movieId);
  }

  @override
  Future<List<Bookmarked>> getBookmarkedMovies() async {
    final movieBox = await Hive.openBox('movieBox');
    final movieIds = movieBox.keys;
    List<Bookmarked> movies = [];
    for (var movieId in movieIds) {
      final movie = movieBox.get(movieId);
      if (movie != null) {
        movies.add(movieBox.get(movieId));
      }
    }
    return movies;
  }
}
