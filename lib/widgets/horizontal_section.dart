
import 'package:flutter/material.dart';
import 'package:movies_app/constants/app_theme.dart';

import 'horizontal_list.dart';

class HorizontalSection extends StatefulWidget {
  final String title;
  final Widget list;
  final HorizontalList? hList;
  const HorizontalSection({required this.title, required this.list, this.hList, Key? key}) : super(key: key);

  @override
  State<HorizontalSection> createState() => _HorizontalSectionState();
}

class _HorizontalSectionState extends State<HorizontalSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryDark,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: onPrimaryDark
              ),
            ),
          ),
          Expanded(child: widget.hList ?? widget.list),
        ],
      ),
    );
  }
}
