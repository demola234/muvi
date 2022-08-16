import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moviex/core/utils/customs/customs_configs.dart';
import 'package:moviex/features/movies/presentation/search/controller/provider/search_movies_provider.dart';

import '../../../../../core/api/api_const.dart';
import '../../../../../core/utils/navigator/navigation_services.dart';
import '../../../domain/entities/movies_result.dart';
import '../../movies/controllers/providers/movies_provider.dart';
import '../../movies/controllers/states/movie_state.dart';
import '../../movies/views/movies_details.dart';
import '../controller/state/search_state.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF26272B),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          snap: false,
          pinned: false,
          floating: true,
          backgroundColor: Color(0xFF26272B),
          expandedHeight: 90,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Column(
              children: [
                YMargin(20),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ProbitasTextFormField(
                      controller: searchController,
                      hintText: "Search for Movies, Tv shows, etc",
                      onChanged: (v) {
                        setState(() {
                          v = searchController.text;
                          // print(v);
                        });
                      },
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  searchController.clear();
                                });
                              },
                              icon: Icon(Icons.cancel),
                              color: Colors.white,
                            )
                          : SizedBox.shrink(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          sliver: searchController.text.isEmpty
              ? ref.watch<MovieListState>(movieAllPopularNotifier).maybeMap(
                    orElse: () => SliverToBoxAdapter(),
                    initial: (_) => SliverToBoxAdapter(),
                    empty: (_) => SliverToBoxAdapter(
                      child: const Center(
                        child: Text("Unable to Get Trending Movies"),
                      ),
                    ),
                    loading: (_) => SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (value) => SliverToBoxAdapter(
                      child: Center(
                        child: Text("Unable to Fetch Data"),
                      ),
                    ),
                    loaded: (l) => SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 200),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: Duration(milliseconds: 800),
                          columnCount: 3,
                          child: ScaleAnimation(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            scale: 1.5,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                  onTap: () {
                                    print(l.movies[0].title);
                                    NavigationService().navigateToScreen(
                                        MovieDetailsScreen(
                                            movieId: l.movies[index].id));
                                  },
                                  child: SearchMovieList(
                                    movies: l.movies[index],
                                  )),
                            ),
                          ),
                        );
                      }, childCount: l.movies.length),
                    ),
                  )
              : ref
                  .watch<SearchMoviesState>(
                      movieSearchProvider(searchController.text))
                  .maybeWhen(
                    orElse: () => SliverToBoxAdapter(
                      child: const Center(
                        child: Text("Unable to Get Trending Movies"),
                      ),
                    ),
                    initial: () => SliverToBoxAdapter(
                      child: const Center(
                        child: Text("Unable to Get Trending Movies"),
                      ),
                    ),
                    empty: (_) => SliverToBoxAdapter(
                      child: const Center(
                        child: Text("Unable to Get Trending Movies"),
                      ),
                    ),
                    loading: () => SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (value) => SliverToBoxAdapter(
                      child: Center(
                        child: Text("Unable to Fetch Data"),
                      ),
                    ),
                    loaded: (l) {
                      print(l);
                      return ListView.builder(
                        itemCount: l.length,
                        itemBuilder: (context, index) {
                          return Text(l[index].title);
                        },
                      );
                    },
                  ),
        )
      ]),
    );
  }
}

class SearchMovieList extends StatelessWidget {
  MovieEntity movies;
  SearchMovieList({
    required this.movies,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 160,
              width: 160,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    ApiConstants.BASE_IMAGE_URL + movies.backdropPath),
              )),
          YMargin(5),
          Container(
            width: 130,
            child: Text(
              movies.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Config.b1(context)
                  .copyWith(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class ProbitasTextFormField extends StatelessWidget {
  final String? labelText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String input)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final TextAlign textAlign;
  final String? hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool enabled;
  final bool? readOnly;
  final void Function()? onTap;

  const ProbitasTextFormField(
      {Key? key,
      this.labelText,
      this.initialValue,
      this.suffixIcon,
      this.inputType,
      this.onChanged,
      this.onEditingComplete,
      this.onSaved,
      this.validator,
      this.inputFormatters,
      this.maxLines = 1,
      this.focusNode,
      this.textAlign = TextAlign.start,
      this.obscureText = false,
      this.enableInteractiveSelection = true,
      this.hintText,
      this.prefixIcon,
      this.controller,
      this.readOnly = false,
      this.onTap,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      onEditingComplete: onEditingComplete,
      obscureText: obscureText!,
      enableInteractiveSelection: enableInteractiveSelection,
      maxLines: maxLines,
      readOnly: readOnly!,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      initialValue: initialValue,
      keyboardType: inputType,
      textAlign: textAlign,
      enabled: enabled,
      style: Config.b2(context).copyWith(
        color: Colors.white,
      ),
      decoration: InputDecoration(
          fillColor: Colors.grey,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintText: hintText,
          // hintTextDirection: TextDirection.rtl,
          hintStyle: Config.b3(context).copyWith(
            color: Color(0xFFFFFFFF),
          )),
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
    );
  }
}
