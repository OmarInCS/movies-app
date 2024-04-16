

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/constants/app_theme.dart';

import '../../../../api/api_service.dart';
import '../../../../widgets/error_indicator.dart';
import '../../../../widgets/loading_indicator.dart';

class PopularSlider extends StatefulWidget {
  const PopularSlider({Key? key}) : super(key: key);

  @override
  State<PopularSlider> createState() => _PopularSliderState();
}

class _PopularSliderState extends State<PopularSlider> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: APIService.getPopularMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return const ErrorIndicator();
        }
        final movies = snapshot.data!;
        return CarouselSlider.builder(
          itemCount: movies.length,
          options: CarouselOptions(
            autoPlay: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            viewportFraction: 1
          ),
          itemBuilder: (context, idx, pageIdx) {
            var movie = movies[idx];
            return Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: movie.backdropPath == null ? const Placeholder()
                      : movie.backdrop != null ? Image.memory(movie.backdrop!)
                        : FutureBuilder(
                      future: APIService.getBackdropImage(movie.backdropPath!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const LoadingIndicator();
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return const ErrorIndicator();
                        }
                        movie.backdrop = snapshot.data!;
                        return Image.memory(movie.backdrop!, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,);
                      },
                    ),
                ),
                Positioned(
                  bottom: 0,
                  left: 16 + 100,
                  height: 80,
                  right: 0,
                  child: Container(
                    color: primaryDark,
                    width: double.infinity,
                    child: ListTile(
                      title: Text(
                        movie.title,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: onPrimaryDark
                        ),
                      ),
                      subtitle: Text(
                        "${movie.releasedate}",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: containersBackgroundDark
                        ),
                      ),

                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 16,
                  top: 50,
                  width: 100,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: movie.poster != null ? Image.memory(movie.poster!)
                          : FutureBuilder(
                        future: APIService.getPosterImage(movie.posterPath),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const LoadingIndicator();
                          } else if (snapshot.hasError || snapshot.data == null) {
                            return const ErrorIndicator();
                          }
                          movie.poster = snapshot.data!;
                          return Image.memory(movie.poster!, fit: BoxFit.fitHeight,);
                        },
                      ),
                  )
                ),
                Positioned(
                  top: 45,
                  left: 6,
                  height: 50,
                  width: 50,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.bookmark_add_sharp,
                      color: containersBackgroundDark,
                      size: 50,
                    ),
                    onPressed: () {

                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
