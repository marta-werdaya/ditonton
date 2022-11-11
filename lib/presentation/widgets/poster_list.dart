import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/tv.dart';
import '../pages/movie_detail_page.dart';

class PosterList<T> extends StatelessWidget {
  final List<T> posters;

  PosterList(this.posters);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final poster = posters[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                (poster is Movie)
                    ? Navigator.pushNamed(
                        context,
                        MovieDetailPage.ROUTE_NAME,
                        arguments: poster.id,
                      )
                    : (poster is Tv)
                        ? Navigator.pushNamed(
                            context,
                            MovieDetailPage.ROUTE_NAME,
                            arguments: poster.id,
                          )
                        : '';
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: poster is Movie
                      ? '$BASE_IMAGE_URL${poster.posterPath}'
                      : poster is Tv
                          ? '$BASE_IMAGE_URL${poster.posterPath}'
                          : '',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: posters.length,
      ),
    );
  }
}
