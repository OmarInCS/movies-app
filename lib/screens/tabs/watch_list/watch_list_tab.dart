

import 'package:flutter/material.dart';
import 'package:movies_app/providers/watch_list_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_theme.dart';
import '../../../widgets/list_item.dart';

class WatchListTab extends StatefulWidget {
  const WatchListTab({Key? key}) : super(key: key);

  @override
  State<WatchListTab> createState() => _WatchListTabState();
}

class _WatchListTabState extends State<WatchListTab> {
  @override
  Widget build(BuildContext context) {
    var movies = context.watch<WatchListProvider>().movies;

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
  }
}
