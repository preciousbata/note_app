import 'package:flutter/material.dart';

import '../utils/constant.dart';

class AppIcon extends StatelessWidget {
  final VoidCallback press;
  final IconData icon;
  final String? tooltip;
  const AppIcon({
    Key? key,
    required this.press,
    required this.icon,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: tooltip,
        onPressed: press,
        splashRadius: kIconButtonSplashRadius,
        icon: Icon(icon));
  }
}
