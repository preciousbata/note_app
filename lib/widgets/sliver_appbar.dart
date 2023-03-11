import 'package:flutter/material.dart';

class AppSliverAppBar extends StatelessWidget {
  final String titleText;
  final IconData? icon;
  const AppSliverAppBar({
    Key? key,
    required this.titleText,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(
            width: 10.0,
          ),
          Text(titleText),
        ],
      ),
      floating: true,
    );
  }
}
