
import 'package:flutter/material.dart';

import '../constants/app_theme.dart';

class Poster extends StatefulWidget {
  final Image poster;
  const Poster({required this.poster, Key? key}) : super(key: key);

  @override
  State<Poster> createState() => _PosterState();
}

class _PosterState extends State<Poster> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 154,
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
            left: 26,
            height: 30,
            width: 30,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.bookmark_add_sharp,
                color: containersBackgroundDark,
                size: 30,
              ),
              onPressed: () {

              },
            ),
          ),
        ],
      ),
    );
  }
}
