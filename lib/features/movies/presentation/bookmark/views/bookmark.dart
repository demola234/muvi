import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moviex/core/shared/image_path.dart';
import 'package:moviex/core/utils/navigator/navigation_services.dart';
import 'package:moviex/features/movies/presentation/bookmark/controller/state/bookmark_state.dart';
import 'package:moviex/features/movies/presentation/movies/views/movies_details.dart';

import '../../../../../core/api/api_const.dart';
import '../../../../../core/utils/customs/customs_configs.dart';
import '../controller/provider/bookmark_provider.dart';

class MyWidget extends ConsumerStatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF26272B),
      body: SafeArea(
        child: Column(
          children: [
            YMargin(20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Text("Bookmarks",
                        style:
                            Config.b4(context).copyWith(color: Colors.white)),
                    YMargin(10),
                    Expanded(
                      child: Container(
                          width: context.screenWidth(),
                          child: ref
                              .watch<BookmarkListState>(
                                  movieBookmarkNotifierProvider)
                              .maybeMap(
                                orElse: () => Center(
                                  child: Text("No Movie is Bookmarked",
                                      style: Config.h3(context).copyWith(
                                          fontSize: 14, color: Colors.white)),
                                ),
                                initial: (_) => Center(
                                  child: Text("No Movie is Bookmarked",
                                      style: Config.h3(context).copyWith(
                                          fontSize: 14, color: Colors.white)),
                                ),
                                empty: (_) => SizedBox(
                                  height: MediaQuery.of(context).size.height -
                                      AppBar().preferredSize.height -
                                      kBottomNavigationBarHeight -
                                      kToolbarHeight,
                                  child: Center(
                                    child: Text("No Movie is Bookmarked",
                                        style: Config.h3(context).copyWith(
                                            fontSize: 14, color: Colors.white)),
                                  ),
                                ),
                                loaded: (l) => Container(
                                  child: AnimationLimiter(
                                    child: ListView.builder(
                                      itemCount: l.movies.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
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
                                                      child: Dismissible(
                                                          key: UniqueKey(),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            height: 100,
                                                            width: context
                                                                .screenWidth(),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  height: 120,
                                                                  width: 80,
                                                                  child: Image(
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    colorBlendMode:
                                                                        BlendMode
                                                                            .color,
                                                                    image:
                                                                        NetworkImage(
                                                                      ApiConstants
                                                                              .BASE_IMAGE_URL +
                                                                          l.movies[index]
                                                                              .posterPath,
                                                                    ),
                                                                  ),
                                                                ),
                                                                XMargin(10),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      l.movies[index]
                                                                          .title,
                                                                      style: Config.h3(context).copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    YMargin(10),
                                                                    Container(
                                                                        width:
                                                                            230,
                                                                        child:
                                                                            Text(
                                                                          l.movies[index]
                                                                              .overview,
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: Config.h3(context).copyWith(
                                                                              fontSize: 12,
                                                                              color: Colors.white),
                                                                        ))
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          background: Container(
                                                            child: Center(
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                              MuviAssets.delete,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                            color: Colors.red,
                                                          ),
                                                          onDismissed:
                                                              (direction) {
                                                            ref
                                                                .read(deleteBookmarkNotifier(l
                                                                        .movies[
                                                                            index]
                                                                        .id)
                                                                    .notifier)
                                                                .deleteBookmark(l
                                                                    .movies[
                                                                        index]
                                                                    .id);
                                                          }),
                                                    ),
                                                  ),
                                                ));
                                      },
                                    ),
                                  ),
                                ),
                                loading: (_) => Center(
                                    child: const CircularProgressIndicator()),
                              )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
