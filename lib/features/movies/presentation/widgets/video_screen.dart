import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviex/core/utils/navigator/navigation_services.dart';
import 'package:moviex/features/movies/presentation/controllers/providers/movies_provider.dart';
import 'package:moviex/features/movies/presentation/controllers/states/video_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends ConsumerStatefulWidget {
  final int movieId;
  const VideoScreen({required this.movieId, super.key});

  @override
  ConsumerState<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends ConsumerState<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ref
            .watch<VideoState>(movieVideoNotifier(widget.movieId))
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
              loaded: (l) => Stack(
                children: [
                  Center(
                    child: YoutubePlayer(
                        controller: YoutubePlayerController(
                            initialVideoId: l.movies[0].key)),
                  ),
                  Positioned(
                      child: IconButton(
                    onPressed: () {
                      NavigationService().goBack();
                    },
                    icon: Icon(Icons.close),
                  ))
                ],
              ),
              loading: (_) => Center(child: const CircularProgressIndicator()),
            ));
  }
}
