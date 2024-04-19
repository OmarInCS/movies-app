

import 'package:flutter/material.dart';
import 'package:movies_app/widgets/horizontal_section.dart';
import 'package:movies_app/screens/tabs/home/widgets/popular_slider.dart';

import '../../../api/api_service.dart';
import '../../../widgets/horizontal_list.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          child: PopularSlider()
        ),
        SizedBox(height: 16,),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.29,
            width: double.infinity,
            child: HorizontalSection(
              title: "New Releases",
              list: HorizontalList(
                dataFunction: () => APIService.getUpcomingMovies(),
                withFooter: false,
              ),
            )
        ),
        SizedBox(height: 16,),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.29,
            width: double.infinity,
            child: HorizontalSection(
              title: "Recommended",
              list: HorizontalList(
                dataFunction: () => APIService.getTopRatedMovies(),
              ),
            )
        ),

      ],
    );
  }
}
