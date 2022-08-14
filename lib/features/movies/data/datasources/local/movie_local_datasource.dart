import 'package:moviex/features/movies/data/model/bookmarked.dart';

abstract class MoviesLocalDataSource{
    Future<void> bookMovie(Bookmarked movieTable);
  Future<List<Bookmarked>> getBookmarkedMovies();
  Future<void> deleteBookmarkedMovie(int movieId);
  Future<bool> checkIfMovieBookmarked(int movieId);
}