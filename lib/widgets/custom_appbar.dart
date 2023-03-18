import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/utils/constant.dart';

class CustomAppBar extends StatelessWidget {
  final String titleText;
  final IconData? icon;
  final IconData? secondIcon;
  final void Function() onPressed;

  const CustomAppBar({
    Key? key,
    required this.titleText,
    required this.icon,
    required this.secondIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleText,
              style: GoogleFonts.nunito(
                fontSize: 43,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: lightGray),
              child: Center(
                child: Icon(icon),
              ),
            ),
            GestureDetector(
              onTap: onPressed,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: lightGray),
                child: Center(
                  child: Icon(secondIcon),
                ),
              ),
            ),
          ]),
    );
  }
}
