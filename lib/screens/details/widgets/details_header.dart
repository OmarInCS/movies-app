
import 'package:flutter/material.dart';

import '../../../api/api_service.dart';
import '../../../constants/app_theme.dart';
import '../../../models/movie.dart';
import '../../../widgets/error_indicator.dart';
import '../../../widgets/loading_indicator.dart';

class DetailsHeader extends StatefulWidget {
  final Movie movie;
  const DetailsHeader({required this.movie, Key? key}) : super(key: key);

  @override
  State<DetailsHeader> createState() => _DetailsHeaderState();
}

class _DetailsHeaderState extends State<DetailsHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: widget.movie.backdrop != null ? Image.memory(widget.movie.backdrop!)
              : FutureBuilder(
            future: APIService.getBackdropImage(widget.movie.backdropPath),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingIndicator();
              } else if (snapshot.hasError || snapshot.data == null) {
                return const ErrorIndicator();
              }
              widget.movie.backdrop = snapshot.data!;
              return Image.memory(widget.movie.backdrop!, fit: BoxFit.cover,);
            },
          ),
        ),
        ListTile(
          tileColor: primaryDark,
          title: Text(
            widget.movie.title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: onPrimaryDark
            ),
          ),
          subtitle: Text(
            "${widget.movie.releasedate}",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: containersBackgroundDark
            ),
          ),

        ),

      ],
    );
  }
}
