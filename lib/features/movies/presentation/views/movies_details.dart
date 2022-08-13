import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moviex/core/shared/image_path.dart';
import 'package:moviex/core/utils/customs/customs_configs.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
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
                background: Stack(
                  children: [
                    Container(
                      height: 450,
                      width: context.screenWidth(),
                      child: Image(
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.color,
                        image: NetworkImage(
                          "https://www.themoviedb.org/t/p/w1280/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg",
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
                              "Luck",
                              style: Config.h1(context)
                                  .copyWith(color: Colors.white),
                            ),
                            YMargin(5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "1h 29m",
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
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF6CB36),
                                      shape: BoxShape.circle),
                                ),
                                XMargin(5),
                                Text(
                                  "Animation",
                                  style: Config.b3(context).copyWith(
                                      fontSize: 14, color: Colors.white),
                                )
                              ],
                            )
                          ],
                        )),
                  ],
                )),
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
                    text: "Play",
                    color: Color(0xFFF6CB36),
                    colorText: Color(0xFF292D32),
                  ),
                  Spacer(),
                  Buttons(
                    assetName: MuviAssets.plus,
                    text: "My List",
                    color: Colors.transparent,
                    colorText: Color(0xFFACACAC),
                    border: Border.all(color: Color(0xFFACACAC)),
                  ),
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
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Three siblings who move into their ancestral estate after their father's gruesome murder discover their new home's magical keys, which must be used in their stand against an evil creature who wants the keys and their powers.",
                          style: Config.b3(context).copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
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
  const Buttons({
    required this.text,
    required this.assetName,
    required this.color,
    required this.colorText,
    this.border,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          XMargin(3),
          Text(
            text,
            style: Config.b2(context).copyWith(
              color: colorText,
            ),
          )
        ],
      ),
    );
  }
}
