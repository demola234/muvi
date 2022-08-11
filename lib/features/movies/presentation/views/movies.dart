import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviex/features/movies/presentation/controllers/providers/movies_provider.dart';
import 'package:moviex/features/movies/presentation/controllers/states/movie_state.dart';


class Movies extends ConsumerWidget {
  const Movies({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final movies = ref.watch(movieNotifierProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ref.watch<MovieListState>(movieNotifierProvider).maybeMap(
                  orElse: () => Container(),
                  initial: (_) => Container(),
                  empty: (_) => SizedBox(
                    height: MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height -
                        kBottomNavigationBarHeight -
                        kToolbarHeight,
                    child: const Center(
                      child: Text("You haven't added anything to favorites"),
                    ),
                  ),
                  loaded: (l) => Container(
                    child: Text(l.movies[2].title),
                  ),
                  loading: (_) => const CircularProgressIndicator(),
                ),
          ],
        ),
      ),
    );
  }
}
