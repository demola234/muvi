// import 'package:dartz/dartz.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:moviex/features/movies/domain/entities/movies.dart';
// import 'package:moviex/features/movies/domain/repositories/movie_repository.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:moviex/features/movies/domain/usecases/fetch_movies.dart';

// class MockMovieRepository extends Mock implements MovieRepository {}
// @GenerateMocks([MovieRepository])
// void main() {
//   late MockMovieRepository mockMovieRepository;
//   late FetchMovies usecase;

//   setUp(() {
//     mockMovieRepository = MockMovieRepository();
//     usecase = FetchMovies(mockMovieRepository);
//   });

//   final tMovies = Movie(totalPages: 20, page: 1, results: [], totalResults: 20);

//   test(' get movies from the repository', () async {
//     when(mockMovieRepository.getAllMovieCategories()).thenAnswer(
//       (realInvocation) async => Right(tMovies),
//     );

//     final result = await usecase();
//     expect(result, Right(tMovies));
//     verify(mockMovieRepository.getAllPopularMovies());
//     verifyNoMoreInteractions(mockMovieRepository);
//   });
// }
