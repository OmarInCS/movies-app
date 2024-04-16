
import 'package:flutter/material.dart';
import 'package:movies_app/constants/app_theme.dart';

import '../../../api/api_service.dart';
import '../../../widgets/error_indicator.dart';
import '../../../widgets/loading_indicator.dart';
import 'widgets/serach_result_item.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16)
              )
            ),
            onChanged: (value) {
              setState(() {

              });
            },
          ),
        ),
        if(_searchController.text.isNotEmpty)
          Expanded(
            child: FutureBuilder(
              future: APIService.getSearchedMovies(_searchController.text),
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
                        SearchResultItem(
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
          )
      ],
    );
  }
}
