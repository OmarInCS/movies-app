

import 'package:flutter/material.dart';

import '../../api/api_service.dart';
import '../../constants/app_theme.dart';
import '../../models/genre.dart';
import '../../widgets/error_indicator.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/list_item.dart';

class GenreMovies extends StatefulWidget {
  final Genre genre;
  const GenreMovies({required this.genre, Key? key}) : super(key: key);

  @override
  State<GenreMovies> createState() => _GenreMoviesState();
}

class _GenreMoviesState extends State<GenreMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.genre.name
        ),
        backgroundColor: primaryDark,
        foregroundColor: onPrimaryDark,
        titleTextStyle: TextStyle(
            color: onPrimaryDark
        ),
      ),
      body: FutureBuilder(
        future: APIService.getMoviesOfGenre(widget.genre.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.hasError || snapshot.data == null) {
            return const ErrorIndicator();
          }
          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListItem(
                    movie: movies[index],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      thickness: 2,
                      height: 2,
                      color: onContainerDark,
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
