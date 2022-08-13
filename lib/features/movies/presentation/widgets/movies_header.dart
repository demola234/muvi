import 'package:flutter/material.dart';
import 'package:moviex/core/utils/customs/customs_configs.dart';
import 'dart:ui' as ui;
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/api/api_const.dart';
import '../../domain/entities/movies_result.dart';

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
