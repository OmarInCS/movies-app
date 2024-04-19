
import 'package:flutter/material.dart';

import '../constants/app_theme.dart';
import 'movie_rate.dart';

class PosterWithFooter extends StatefulWidget {
  final Image poster;
  final double voteAverage;
  final String title;
  final String releaseDate;
  final void Function() onBookmarkPressed;
  final bool isInWatchList;

  const PosterWithFooter({required this.poster, required this.voteAverage, required this.title, required this.releaseDate, required this.onBookmarkPressed, required this.isInWatchList, Key? key}) : super(key: key);

  @override
  State<PosterWithFooter> createState() => _PosterWithFooterState();
}

class _PosterWithFooterState extends State<PosterWithFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154,
      height: 154,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8)
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              top: 0,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: widget.poster,
              )
          ),
          Positioned(
            top: 0,
            left: 0,
            height: 30,
            width: 30,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                widget.isInWatchList ?  Icons.bookmark_added_sharp : Icons.bookmark_add_sharp,
                color: widget.isInWatchList ? onPrimarySelectedDark : containersBackgroundDark,
                size: 30,
              ),
              onPressed: widget.onBookmarkPressed,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 60,
            child: Container(
              color: containersBackgroundDark,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MovieRate(voteAverage: widget.voteAverage),
                  SizedBox(height: 2,),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: onPrimaryDark
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(height: 2,),
                  Text(
                    "${widget.releaseDate}",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: onContainerDark
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
