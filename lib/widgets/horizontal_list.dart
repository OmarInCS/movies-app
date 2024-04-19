

import 'package:flutter/material.dart';
import 'package:movies_app/providers/watch_list_provider.dart';
import 'package:movies_app/widgets/poster.dart';
import 'package:movies_app/widgets/poster_with_footer.dart';
import 'package:provider/provider.dart';

import '../../../../api/api_service.dart';
import '../../../../widgets/error_indicator.dart';
import '../../../../widgets/loading_indicator.dart';
import '../models/movie.dart';
import '../screens/details/details_screen.dart';

class HorizontalList extends StatefulWidget {
  final Future<List<Movie>> Function() dataFunction;
  final bool withFooter;
  const HorizontalList({required this.dataFunction, this.withFooter = true, Key? key}) : super(key: key);

  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.dataFunction(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return const ErrorIndicator();
        }
        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, idx) {
            var movie = movies[idx];
            if(widget.withFooter) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(movieId: movie.id, movieName: movie.title),));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: movie.backdropPath == null ? const Placeholder()
                      : movie.poster != null ?
                      PosterWithFooter(
                        poster: Image.memory(movie.poster!, fit: BoxFit.fitWidth, alignment: Alignment.topCenter),
                        voteAverage: movie.voteaverage,
                        title: movie.title,
                        releaseDate: movie.releasedate,
                        isInWatchList: context.watch<WatchListProvider>().isInWatchList(movieId: movie.id),
                        onBookmarkPressed: () {
                          if(context.read<WatchListProvider>().isInWatchList(movieId: movie.id)) {
                            context.read<WatchListProvider>().deleteMovie(
                                movieId: movie.id);
                          }
                          else {
                            context.read<WatchListProvider>().addMovie(
                                movie: movie);
                          }
                        },
                      )
                      : FutureBuilder(
                    future: APIService.getPosterImage(movie.posterPath!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingIndicator();
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return const ErrorIndicator();
                      }
                      movie.poster = snapshot.data!;
                      return PosterWithFooter(
                        poster: Image.memory(movie.poster!, fit: BoxFit.fitWidth, alignment: Alignment.topCenter),
                        voteAverage: movie.voteaverage,
                        title: movie.title,
                        releaseDate: movie.releasedate,
                        isInWatchList: context.watch<WatchListProvider>().isInWatchList(movieId: movie.id),
                        onBookmarkPressed: () {
                          if(context.read<WatchListProvider>().isInWatchList(movieId: movie.id)) {
                            context.read<WatchListProvider>().deleteMovie(
                                movieId: movie.id);
                          }
                          else {
                            context.read<WatchListProvider>().addMovie(
                                movie: movie);
                          }
                        },
                      );
                    },
                  ),
                ),
              );
            }
            else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(movieId: movie.id, movieName: movie.title),));
                  },
                  child: movie.backdropPath == null ? const Placeholder()
                      : movie.poster != null
                      ? Poster(
                          poster: Image.memory(movie.poster!, fit: BoxFit.cover,),
                          isInWatchList: context.watch<WatchListProvider>().isInWatchList(movieId: movie.id),
                          onBookmarkPressed: () {
                            if(context.read<WatchListProvider>().isInWatchList(movieId: movie.id)) {
                              context.read<WatchListProvider>().deleteMovie(
                                  movieId: movie.id);
                            }
                            else {
                              context.read<WatchListProvider>().addMovie(
                                  movie: movie);
                            }
                          },
                        )
                      : FutureBuilder(
                    future: APIService.getPosterImage(movie.posterPath!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingIndicator();
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return const ErrorIndicator();
                      }
                      movie.poster = snapshot.data!;
                      return Poster(
                        poster: Image.memory(movie.poster!, fit: BoxFit.cover,),
                        isInWatchList: context.watch<WatchListProvider>().isInWatchList(movieId: movie.id),
                        onBookmarkPressed: () {
                          if(context.read<WatchListProvider>().isInWatchList(movieId: movie.id)) {
                            context.read<WatchListProvider>().deleteMovie(
                                movieId: movie.id);
                          }
                          else {
                            context.read<WatchListProvider>().addMovie(
                                movie: movie);
                          }
                        },
                      );
                    },
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
