import 'package:flutter/material.dart';

import '../../../../../core/api/api_const.dart';
import '../../../../../core/utils/customs/customs_configs.dart';
import '../../../../../core/utils/navigator/navigation_services.dart';
import '../../../domain/entities/movies_result.dart';
import '../views/movies_details.dart';

class MoviesList extends StatelessWidget {
  final MovieEntity l;
  const MoviesList({
    required this.l,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService().navigateToScreen(MovieDetailsScreen(movieId: l.id));
      },
      child: Padding(
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
                  image: NetworkImage(
                      ApiConstants.BASE_IMAGE_URL + l.backdropPath!),
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
                style: Config.b3(context)
                    .copyWith(fontSize: 8, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
