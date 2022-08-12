import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:moviex/core/shared/image_path.dart';
import 'dart:ui' as ui;
import 'package:moviex/core/utils/customs/customs_configs.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:moviex/features/movies/presentation/controllers/providers/movies_provider.dart';
import 'package:moviex/features/movies/presentation/controllers/states/movie_state.dart';

import '../../../../core/api/api_const.dart';
import '../../domain/entities/movies_result.dart';

class Movies extends ConsumerWidget {
  const Movies({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final movies = ref.watch(movieNotifierProvider);
    return Scaffold(
        backgroundColor: Color(0xFF1C1C1C),
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
                        loading: (_) => const CircularProgressIndicator(),
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
                              loading: (_) => const CircularProgressIndicator(),
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
                              loading: (_) => const CircularProgressIndicator(),
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
                              loading: (_) => const CircularProgressIndicator(),
                            )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class MoviesList extends StatelessWidget {
  final MovieEntity l;
  const MoviesList({
    required this.l,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              // padding: EdgeInsets.symmetric(horizontal: 10),
              height: 167,
              width: 140,
              child: Image(
                fit: BoxFit.cover,
                image:
                    NetworkImage(ApiConstants.BASE_IMAGE_URL + l.backdropPath!),
              )),
          YMargin(5),
          Container(
            width: 130,
            child: Text(
              l.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Config.b1(context)
                  .copyWith(fontSize: 12, color: Colors.white),
            ),
          ),
          Container(
            width: 130,
            child: Text(
              l.overview!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  Config.b3(context).copyWith(fontSize: 8, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieHeader extends StatelessWidget {
  final MovieEntity l;
  MovieHeader({
    required this.l,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 470,
            width: context.screenWidth(),
            // color: Colors.green,
            child: Image(
              fit: BoxFit.cover,
              image:
                  NetworkImage(ApiConstants.BASE_IMAGE_URL + l.backdropPath!),
            )),
        Positioned.fill(
            bottom: 0,
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                // sigmaX: 0.0,
                sigmaY: 1.0,
              ),
              child: Container(
                  width: 460,
                  height: 65,
                  decoration: BoxDecoration(
                    backgroundBlendMode: BlendMode.darken,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.7,
                          1.3,
                        ],
                        colors: [
                          Color(0xFF1C1C1C).withOpacity(0.1),
                          Color(0xFF1C1C1C),
                        ]),
                  )),
            )),
        Positioned(
          bottom: 40,
          left: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.title,
                style: Config.b1(context)
                    .copyWith(fontSize: 25, color: Colors.white),
              ),
              Row(
                children: [
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Color(0xFFFECE00),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Text(
                      "HD",
                      style: Config.b1(context)
                          .copyWith(fontSize: 14, color: Colors.black),
                    )),
                  ),
                  XMargin(8),
                  Text(
                    timeago.format(DateTime.parse(l.releaseDate!)),
                    style: Config.b1(context)
                        .copyWith(fontSize: 12, color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

//  SliverList(
//               delegate: SliverChildBuilderDelegate((context, index) {
//                 return Column(
//                   children: [
//                     Text("Trending Now"),
//                     ListView.builder(
//                       itemCount: 2,
//                       itemBuilder: (context, index) {
//                         return Container();
//                       },
//                     )
//                   ],
//                 );
//               }),
//             )