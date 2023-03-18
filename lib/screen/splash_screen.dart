import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/screen/homescreen.dart';

import '../utils/constant.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splashscreen';
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashBody(),
    );
  }
}

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  int currentIndex = 0;
  List<String> imageList = [
    'assets/memo.svg',
    'assets/notepad.svg',
    'assets/notes-record.svg'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: imageList.length,
                itemBuilder: (context, index) =>
                    SplashScreenImage(
                  image: imageList[index],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20),
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                            imageList.length,
                            (index) => Padding(
                                  padding:
                                      const EdgeInsets.only(
                                          left: 8.0),
                                  child:
                                      buildCustomDot(index),
                                ))
                      ],
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 18.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(
                                      context,
                                      HomeScreen.routeName),
                              style: ButtonStyle(
                                shape: MaterialStateProperty
                                    .all(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius
                                            .circular(20),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty
                                        .all(white),
                              ),
                              child: Text('Continue',
                                  style: GoogleFonts.nunito(
                                      fontSize: 25,
                                      color: primaryColor,
                                      fontWeight:
                                          FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomDot(int index) {
    return AnimatedContainer(
      height: 9,
      width: currentIndex == index ? 28 : 9,
      decoration: BoxDecoration(
        color: currentIndex == index ? white : lightGray,
        borderRadius: BorderRadius.circular(3),
      ),
      duration: animationDuration,
    );
  }
}

class SplashScreenImage extends StatelessWidget {
  final String image;

  const SplashScreenImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        const Text(
          'NOTEZ',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: primaryColor),
        ),
        const Spacer(
          flex: 2,
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 18.0),
          child: SvgPicture.asset(
            image,
            height: 520,
            width: 465,
          ),
        ),
      ],
    );
  }
}
