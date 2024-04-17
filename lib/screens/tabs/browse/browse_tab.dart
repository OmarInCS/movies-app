

import 'package:flutter/material.dart';
import 'package:movies_app/screens/genre_movies/genre_movies.dart';

import '../../../api/api_service.dart';
import '../../../constants/app_theme.dart';
import '../../../widgets/error_indicator.dart';
import '../../../widgets/loading_indicator.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: APIService.getGenres(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return const ErrorIndicator();
        }
        final genres = snapshot.data!;
        return GridView.builder(
          itemCount: genres.length,
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 6 / 4
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GenreMovies(genre: genres[index]),));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if(["action", "animation", "comedy"].contains(genres[index].name.toLowerCase()))
                        Image.asset("assets/images/${genres[index].name.toLowerCase()}.jpg", fit: BoxFit.cover,),
                      if(!["action", "animation", "comedy"].contains(genres[index].name.toLowerCase()))
                        const Placeholder(),

                      Center(
                        child: Text(
                          genres[index].name,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: onPrimaryDark
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
