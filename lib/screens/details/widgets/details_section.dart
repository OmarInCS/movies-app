
import 'package:flutter/material.dart';
import 'package:movies_app/constants/app_theme.dart';
import 'package:movies_app/widgets/movie_rate.dart';

import '../../../api/api_service.dart';
import '../../../models/movie.dart';
import '../../../widgets/error_indicator.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/poster.dart';

class DetailsSection extends StatefulWidget {
  final Movie movie;
  const DetailsSection({required this.movie, Key? key}) : super(key: key);

  @override
  State<DetailsSection> createState() => _DetailsSectionState();
}

class _DetailsSectionState extends State<DetailsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryDark,
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            width: 154,
            child: widget.movie.poster != null ? Poster(poster: Image.memory(widget.movie.poster!, fit: BoxFit.contain,))
                : FutureBuilder(
              future: APIService.getPosterImage(widget.movie.posterPath),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const ErrorIndicator();
                }
                widget.movie.poster = snapshot.data!;
                return Poster(poster: Image.memory(widget.movie.poster!, fit: BoxFit.contain,));
              },
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  children: [
                    for (var genre in widget.movie.genres!)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: containersBackgroundDark),

                          ),
                          child: Text(
                            genre,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: onContainerDark
                            ),
                          ),
                        )
                  ],
                ),
                Text(
                  widget.movie.overview,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: onContainerDark
                  ),
                ),
                MovieRate(
                  voteAverage: widget.movie.voteaverage,
                  size: 32,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
