import 'package:flutter/material.dart';

import '../utils/constant.dart';
import '../widgets/custom_button.dart';

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
    'assets/images/note1.jpg',
    'assets/images/note2.jpg',
    'assets/images/note3.jpg'
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
                    SplashContent(
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
                            (index) =>
                                buildCustomDot(index))
                      ],
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 18.0),
                      child: DefaultButton(
                        text: 'Continue',
                        press: () {},
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
        color: currentIndex == index
            ? primaryColor
            : Colors.transparent,
        borderRadius: BorderRadius.circular(3),
      ),
      duration: animationDuration,
    );
  }
}

class SplashContent extends StatelessWidget {
  final String image;

  const SplashContent({
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
          child: Image(
            height: 520,
            width: 465,
            image: AssetImage(image),
          ),
        ),
      ],
    );
  }
}
