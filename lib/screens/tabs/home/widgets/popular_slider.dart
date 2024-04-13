

import 'package:flutter/material.dart';

import '../../../../api/api_service.dart';
import '../../../../widgets/error_indicator.dart';
import '../../../../widgets/loading_indicator.dart';

class PopularSlider extends StatefulWidget {
  const PopularSlider({Key? key}) : super(key: key);

  @override
  State<PopularSlider> createState() => _PopularSliderState();
}

class _PopularSliderState extends State<PopularSlider> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: APIService.getPopularMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return const ErrorIndicator();
        }
        final movies = snapshot.data!;
        return Expanded(
          child: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, idx) => Text(movies[idx].title),
          ),
        );
      },
    );
  }
}
