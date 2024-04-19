

import 'package:flutter/material.dart';
import 'package:movies_app/constants/app_theme.dart';
import 'package:movies_app/screens/details/widgets/details_header.dart';
import 'package:movies_app/screens/details/widgets/details_section.dart';
import 'package:movies_app/widgets/horizontal_list.dart';

import '../../api/api_service.dart';
import '../../widgets/error_indicator.dart';
import '../../widgets/horizontal_section.dart';
import '../../widgets/loading_indicator.dart';

class DetailsScreen extends StatefulWidget {
  final int movieId;
  final String movieName;

  const DetailsScreen({required this.movieId, required this.movieName, Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movieName
        ),
        backgroundColor: primaryDark,
        foregroundColor: onPrimaryDark,
        titleTextStyle: TextStyle(
          color: onPrimaryDark
        ),
      ),
      body: FutureBuilder(
        future: APIService.getMovieDetails(widget.movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.hasError || snapshot.data == null) {
            return const ErrorIndicator();
          }
          final movie = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  child: DetailsHeader(movie: movie,)
              ),
              SizedBox(height: 16,),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.29,
                  width: double.infinity,
                  child: DetailsSection(
                    movie: movie,
                  )
              ),
              SizedBox(height: 16,),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.29,
                  width: double.infinity,
                  child: HorizontalSection(
                    title: "More Like This",
                    list: HorizontalList(
                      dataFunction: () => APIService.getSimilarMovies(movie.id),
                    ),
                  )
              ),

            ],
          );
        },
      ),
    );
  }
}
