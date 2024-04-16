
import 'package:flutter/material.dart';

import '../constants/app_theme.dart';

class MovieRate extends StatelessWidget {
  final double voteAverage;
  final double size;
  const MovieRate({required this.voteAverage, this.size = 16, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: onPrimarySelectedDark,
          size: size,
        ),
        SizedBox(width: 2,),
        Text(
          "${(voteAverage * 10).roundToDouble() / 10}",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: onPrimaryDark,
            fontSize: size - 4
          ),
        ),
      ],
    );
  }
}
