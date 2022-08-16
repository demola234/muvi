import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:moviex/core/shared/image_path.dart';
import 'package:moviex/core/utils/customs/customs_configs.dart';

import '../controllers/providers/movies_provider.dart';
import '../controllers/states/movie_state.dart';
import '../widgets/movie_list.dart';
import '../widgets/movies_header.dart';

class Movies extends ConsumerWidget {
  const Movies({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final movies = ref.watch(movieNotifierProvider);
    return Scaffold(
        backgroundColor: Color(0xFF26272B),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              height: 35,
              width: 100,
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage(MuviAssets.applogo),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 400,
                  width: context.screenWidth(),
                  child: ref
                      .watch<MovieListState>(movieAllNowPlayingNotifier)
                      .maybeMap(
                        orElse: () => Container(),
                        initial: (_) => Container(),
                        empty: (_) => SizedBox(
                          height: MediaQuery.of(context).size.height -
                              AppBar().preferredSize.height -
                              kBottomNavigationBarHeight -
                              kToolbarHeight,
                          child: const Center(
                            child:
                                Text("You haven't added anything to favorites"),
                          ),
                        ),
                        loaded: (l) => Container(
                          child: Swiper(
                            autoplay: true,
                            pagination: SwiperPagination(
                                builder: SwiperPagination.rect),
                            autoplayDelay: 30000,
                            itemHeight: 400,
                            fade: 1,
                            itemCount: l.movies.take(5).length,
                            itemBuilder: (context, index) {
                              return MovieHeader(l: l.movies[index]);
                            },
                          ),
                        ),
                        loading: (_) =>
                            Center(child: const CircularProgressIndicator()),
                      )),
              YMargin(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Trending Now",
                          style:
                              Config.b4(context).copyWith(color: Colors.white),
                        )),
                    Container(
                        height: 240,
                        width: context.screenWidth(),
                        child: ref
                            .watch<MovieListState>(
                                movieTrendingNotifierProvider)
                            .maybeMap(
                              orElse: () => Container(),
                              initial: (_) => Container(),
                              empty: (_) => SizedBox(
                                height: MediaQuery.of(context).size.height -
                                    AppBar().preferredSize.height -
                                    kBottomNavigationBarHeight -
                                    kToolbarHeight,
                                child: const Center(
                                  child: Text("Unable to Get Trending Movies"),
                                ),
                              ),
                              loaded: (l) => Container(
                                child: AnimationLimiter(
                                  child: ListView.builder(
                                    itemCount: l.movies.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration.staggeredList(
                                          position: index,
                                          delay: Duration(milliseconds: 100),
                                          child: SlideAnimation(
                                              duration:
                                                  Duration(milliseconds: 2500),
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              child: FadeInAnimation(
                                                  curve: Curves
                                                      .fastLinearToSlowEaseIn,
                                                  duration: Duration(
                                                      milliseconds: 2500),
                                                  child: MoviesList(
                                                      l: l.movies[index]))));
                                    },
                                  ),
                                ),
                              ),
                              loading: (_) => Center(
                                  child: const CircularProgressIndicator()),
                            )),
                  ],
                ),
              ),
              YMargin(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Popular Movies",
                          style:
                              Config.b4(context).copyWith(color: Colors.white),
                        )),
                    Container(
                        height: 240,
                        width: context.screenWidth(),
                        child: ref
                            .watch<MovieListState>(movieAllPopularNotifier)
                            .maybeMap(
                              orElse: () => Container(),
                              initial: (_) => Container(),
                              empty: (_) => SizedBox(
                                height: MediaQuery.of(context).size.height -
                                    AppBar().preferredSize.height -
                                    kBottomNavigationBarHeight -
                                    kToolbarHeight,
                                child: const Center(
                                  child: Text("Unable to Get Popular Movies"),
                                ),
                              ),
                              loaded: (l) => Container(
                                child: AnimationLimiter(
                                  child: ListView.builder(
                                    itemCount: l.movies.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                              position: index,
                                              delay:
                                                  Duration(milliseconds: 100),
                                              child: SlideAnimation(
                                                duration: Duration(
                                                    milliseconds: 2500),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn,
                                                child: FadeInAnimation(
                                                  curve: Curves
                                                      .fastLinearToSlowEaseIn,
                                                  duration: Duration(
                                                      milliseconds: 2500),
                                                  child: MoviesList(
                                                      l: l.movies[index]),
                                                ),
                                              ));
                                    },
                                  ),
                                ),
                              ),
                              loading: (_) => Center(
                                  child: const CircularProgressIndicator()),
                            )),
                  ],
                ),
              ),
              YMargin(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Upcoming Movies",
                          style:
                              Config.b4(context).copyWith(color: Colors.white),
                        )),
                    Container(
                        height: 240,
                        width: context.screenWidth(),
                        child: ref
                            .watch<MovieListState>(moviePlayNowNotifier)
                            .maybeMap(
                              orElse: () => Container(),
                              initial: (_) => Container(),
                              empty: (_) => SizedBox(
                                height: MediaQuery.of(context).size.height -
                                    AppBar().preferredSize.height -
                                    kBottomNavigationBarHeight -
                                    kToolbarHeight,
                                child: const Center(
                                  child: Text("Unable to Get Upcoming Movies"),
                                ),
                              ),
                              loaded: (l) => Container(
                                child: AnimationLimiter(
                                  child: ListView.builder(
                                    itemCount: l.movies.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration.staggeredList(
                                          position: index,
                                          delay: Duration(milliseconds: 100),
                                          child: SlideAnimation(
                                              duration:
                                                  Duration(milliseconds: 2500),
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              child: FadeInAnimation(
                                                  curve: Curves
                                                      .fastLinearToSlowEaseIn,
                                                  duration: Duration(
                                                      milliseconds: 2500),
                                                  child: MoviesList(
                                                      l: l.movies[index]))));
                                    },
                                  ),
                                ),
                              ),
                              // error:  Text("Unable to Get Upcoming Movies"),
                              loading: (_) => Center(
                                  child: const CircularProgressIndicator()),
                            )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
