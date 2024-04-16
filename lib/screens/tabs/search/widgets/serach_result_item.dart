
import 'package:flutter/material.dart';
import 'package:movies_app/constants/app_theme.dart';
import 'package:movies_app/widgets/movie_rate.dart';

import '../../../../api/api_service.dart';
import '../../../../models/movie.dart';
import '../../../../widgets/error_indicator.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../details/details_screen.dart';

class SearchResultItem extends StatefulWidget {
  final Movie movie;
  const SearchResultItem({required this.movie, Key? key}) : super(key: key);

  @override
  State<SearchResultItem> createState() => _SearchResultItemState();
}

class _SearchResultItemState extends State<SearchResultItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(movieId: widget.movie.id, movieName: widget.movie.title),));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8)
              ),
              clipBehavior: Clip.hardEdge,
              width: 154,
              child: widget.movie.backdropPath == null ? const Placeholder()
                  : widget.movie.backdrop != null ? Image.memory(widget.movie.backdrop!, fit: BoxFit.contain,)
                  : FutureBuilder(
                      future: APIService.getBackdropImage(widget.movie.backdropPath!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const LoadingIndicator();
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return const ErrorIndicator();
                        }
                        widget.movie.backdrop = snapshot.data!;
                        return Image.memory(widget.movie.backdrop!, fit: BoxFit.contain,);
                      },
                    ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: onPrimaryDark
                    ),
                  ),
                  Text(
                    widget.movie.releasedate.substring(0, 4),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: onContainerDark
                    ),
                  ),
                  MovieRate(
                    voteAverage: widget.movie.voteaverage,
                    size: 16,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
