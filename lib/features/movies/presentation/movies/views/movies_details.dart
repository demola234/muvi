import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moviex/features/movies/domain/entities/movies_result.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moviex/core/shared/image_path.dart';
import 'package:moviex/core/utils/customs/customs_configs.dart';
import 'package:moviex/core/utils/navigator/navigation_services.dart';

import '../../../../../core/api/api_const.dart';
import '../../bookmark/controller/provider/bookmark_provider.dart';
import '../controllers/providers/movies_provider.dart';
import '../controllers/states/cast_state.dart';
import '../controllers/states/movie_similar_state.dart';
import '../controllers/states/movies_detail_state.dart';
import '../widgets/video_screen.dart';

class MovieDetailsScreen extends ConsumerStatefulWidget {
  final int movieId;
  const MovieDetailsScreen({required this.movieId, super.key});

  @override
  ConsumerState<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends ConsumerState<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    //  final loginState = ref.watch(movieBookmark());
    return Scaffold(
      backgroundColor: Color(0xFF26272B),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: false,
            pinned: false,
            floating: true,
            backgroundColor: Color(0xFF26272B),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: ref
                  .watch<MoviesDetailState>(
                      movieDetailsNotifier(widget.movieId))
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
                    loaded: (l) => (Stack(children: [
                      Container(
                        height: 450,
                        width: context.screenWidth(),
                        child: Image(
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.color,
                          image: NetworkImage(
                            ApiConstants.BASE_IMAGE_URL +
                                l.movies.backdropPath!,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                            decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0x00000000),
                                Color(0xFF1C1C1C),
                              ]),
                        )),
                      ),
                      Positioned(
                        bottom: 40,
                        left: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l.movies.title,
                              style: Config.h3(context)
                                  .copyWith(color: Colors.white),
                            ),
                            YMargin(5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  timeago.format(
                                      DateTime.parse(l.movies.releaseDate!)),
                                  style: Config.b2(context)
                                      .copyWith(color: Colors.white),
                                ),
                                XMargin(5),
                                Container(
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.white)),
                                  child: Center(
                                      child: Text(
                                    "HD",
                                    style: Config.b1(context).copyWith(
                                        fontSize: 10, color: Colors.white),
                                  )),
                                ),
                              ],
                            ),
                            YMargin(10),
                          ],
                        ),
                      )
                    ])),
                    loading: (_) =>
                        Center(child: const CircularProgressIndicator()),
                  ),
            ),
            expandedHeight: 400,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Color(0x00000000),
                    Color(0xFF1C1C1C),
                  ])),
              child: Row(
                children: [
                  Buttons(
                    assetName: MuviAssets.play,
                    onTap: () {
                      NavigationService().navigateToScreen(
                          VideoScreen(movieId: widget.movieId));
                    },
                    text: "Play",
                    color: Color(0xFFF6CB36),
                    colorText: Color(0xFF292D32),
                  ),
                  Spacer(),
                  ref
                      .watch<MoviesDetailState>(
                          movieDetailsNotifier(widget.movieId))
                      .when(
                        empty: (e) => Buttons(
                          assetName: MuviAssets.plus,
                          onTap: () {},
                          text: "My List",
                          color: Colors.transparent,
                          colorText: Color(0xFFACACAC),
                          border: Border.all(color: Color(0xFFACACAC)),
                        ),
                        error: (error) => Buttons(
                          assetName: MuviAssets.plus,
                          onTap: () {},
                          text: "My List",
                          color: Colors.transparent,
                          colorText: Color(0xFFACACAC),
                          border: Border.all(color: Color(0xFFACACAC)),
                        ),
                        loaded: (l) => Buttons(
                          assetName: MuviAssets.plus,
                          onTap: () {
                            MovieEntity movieEntity = MovieEntity(
                                id: widget.movieId,
                                title: l.title,
                                voteAverage: l.voteAverage,
                                backdropPath: l.backdropPath,
                                overview: l.overview!,
                                releaseDate: l.releaseDate,
                                posterPath: l.posterPath);
                            print(movieEntity);
                            ref
                                .watch(movieBookmark(movieEntity).notifier)
                                .addMovieToBookmark(movieEntity: movieEntity);
                            ref
                                .refresh(checkBookmarked.notifier)
                                .checkBookmarked(moviesId: widget.movieId);
                          },
                          text: "My List",
                          color: Colors.transparent,
                          colorText: Color(0xFFACACAC),
                          border: Border.all(color: Color(0xFFACACAC)),
                        ),
                        loading: () => Buttons(
                          assetName: MuviAssets.plus,
                          onTap: () {},
                          text: "My List",
                          color: Colors.transparent,
                          colorText: Color(0xFFACACAC),
                          border: Border.all(color: Color(0xFFACACAC)),
                        ),
                        initial: () => Buttons(
                          assetName: MuviAssets.plus,
                          onTap: () {},
                          text: "My List",
                          color: Colors.transparent,
                          colorText: Color(0xFFACACAC),
                          border: Border.all(color: Color(0xFFACACAC)),
                        ),
                      )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Movie Description",
                          style: Config.b2(context).copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      YMargin(5),
                      ref
                          .watch<MoviesDetailState>(
                              movieDetailsNotifier(widget.movieId))
                          .maybeMap(
                              orElse: () => Container(),
                              initial: (_) => Container(),
                              empty: (_) => SizedBox(
                                    child: const Center(
                                      child:
                                          Text("Unable to Get Trending Movies"),
                                    ),
                                  ),
                              loaded: (l) => Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      l.movies.overview!,
                                      style: Config.b3(context).copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              loading: (_) => Center(
                                  child: const CircularProgressIndicator())),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                YMargin(20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Cast",
                          style: Config.b2(context).copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      YMargin(5),
                      ref
                          .watch<CastState>(movieCastNotifier(widget.movieId))
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
                              height: 170,
                              width: context.screenWidth(),
                              child: AnimationLimiter(
                                child: ListView.builder(
                                    itemCount: l.movies.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: ((context, index) {
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
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () => _showImageDialog(
                                                                context,
                                                                ApiConstants
                                                                        .BASE_IMAGE_URL +
                                                                    l
                                                                        .movies[
                                                                            index]
                                                                        .posterPath,
                                                                l.movies[index]
                                                                    .name),
                                                            child: Container(
                                                                // padding: EdgeInsets.symmetric(horizontal: 10),
                                                                height: 120,
                                                                width: 100,
                                                                child: Image(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(ApiConstants
                                                                          .BASE_IMAGE_URL +
                                                                      l.movies[index]
                                                                          .posterPath),
                                                                )),
                                                          ),
                                                          YMargin(5),
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              l.movies[index]
                                                                  .name,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Config.b1(
                                                                      context)
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )));
                                    })),
                              ),
                            ),
                            loading: (_) => Center(
                                child: const CircularProgressIndicator()),
                          ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                YMargin(20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Recommendations",
                          style: Config.b2(context).copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      YMargin(5),
                      ref
                          .watch<MovieSimilarState>(
                              movieSimilarNotifier(widget.movieId))
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
                              height: 170,
                              width: context.screenWidth(),
                              child: AnimationLimiter(
                                child: ListView.builder(
                                    itemCount: l.movies.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: ((context, index) {
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
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        NavigationService()
                                                            .navigateToScreen(
                                                                MovieDetailsScreen(
                                                                    movieId: l
                                                                        .movies[
                                                                            index]
                                                                        .id));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                // padding: EdgeInsets.symmetric(horizontal: 10),
                                                                height: 120,
                                                                width: 100,
                                                                child: Image(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(ApiConstants
                                                                          .BASE_IMAGE_URL +
                                                                      l.movies[index]
                                                                          .posterPath),
                                                                )),
                                                            YMargin(5),
                                                            Container(
                                                              width: 100,
                                                              child: Text(
                                                                l.movies[index]
                                                                    .title,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: Config.b1(
                                                                        context)
                                                                    .copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )));
                                    })),
                              ),
                            ),
                            loading: (_) => Center(
                                child: const CircularProgressIndicator()),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showImageDialog(BuildContext context, String image, String name) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (_) => Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            Container(
              width: 200,
              height: 40,
              color: Color(0xFFFFFFFFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name,
                      style: Config.b2(context).copyWith(
                        color: Colors.black,
                        fontSize: 18,
                      ))
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: 200,
              height: 200,
              child: Column(
                children: [
                  Image(
                    image: NetworkImage(image),
                  ),
                ],
              ),
            )),
            Container(
              width: 200,
              height: 40,
              color: Color(0xFFFECD00),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => NavigationService().goBack(),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final String text;
  final String assetName;
  final Color color;
  final Color colorText;
  final Border? border;
  final void Function()? onTap;
  const Buttons({
    required this.onTap,
    required this.text,
    required this.assetName,
    required this.color,
    required this.colorText,
    this.border,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 57,
        width: 180,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: border,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(assetName),
            XMargin(5),
            Text(
              text,
              style: Config.b2(context).copyWith(
                color: colorText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
