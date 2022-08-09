import 'package:get_it/get_it.dart';
import '../../features/movies/data/datasources/remote/movie_remote_datasource_impl.dart';
import '../../features/movies/data/datasources/remote/movies_remote_datasource.dart';
import '../../features/movies/data/repositories/movie_repository_impl.dart';
import '../../features/movies/domain/repositories/movie_repository.dart';
import '../../features/movies/domain/usecases/fetch_all_now_playing.dart';
import '../../features/movies/domain/usecases/fetch_now_playing.dart';
import '../../features/movies/domain/usecases/fetch_popular_movies.dart';
import '../../features/movies/domain/usecases/fetch_trending.dart';

final sl = GetIt.I;

Future injector() async {
  //Repository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImp(sl()));

  //DataSources
  sl.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImp());

  ///Usecases
  sl.registerLazySingleton(() => FetchAllPlayNowMovie(sl()));
  sl.registerLazySingleton(() => FetchPlayNowMovies(sl()));
  sl.registerLazySingleton(() => FetchPopularMovies(sl()));
  sl.registerLazySingleton(() => FetchTrendingMovies(sl()));
}
