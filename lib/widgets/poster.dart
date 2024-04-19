
import 'package:flutter/material.dart';

import '../constants/app_theme.dart';

class Poster extends StatefulWidget {
  final Image poster;
  final void Function() onBookmarkPressed;
  final bool isInWatchList;
  const Poster({required this.poster, required this.onBookmarkPressed, required this.isInWatchList, Key? key}) : super(key: key);

  @override
  State<Poster> createState() => _PosterState();
}

class _PosterState extends State<Poster> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      height: 154,
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
        ],
      ),
    );
  }
}
