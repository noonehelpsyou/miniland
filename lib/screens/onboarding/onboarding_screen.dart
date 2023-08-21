import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:miniland/models/models_onboarding.dart';
import 'package:miniland/screens/onboarding/onboarding_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../auth/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pages = [
      OnBoardingWidget(
        model: OnBoardingModel(
            image: "lib/images/onboarding_images/one.png",
            title: "Track You'r children",
            subTitile: "You'r childs information in your fingertips",
            counterText: "1/3",
            txtColor: Colors.white,
            bgColor: const Color.fromARGB(255, 255, 108, 120),
            height: size.height),
      ),
      OnBoardingWidget(
        model: OnBoardingModel(
            image: "lib/images/onboarding_images/two.png",
            title: "Track You'r children",
            subTitile: "You'r childs information in your fingertips",
            counterText: "2/3",
            bgColor: const Color.fromARGB(255, 235, 65, 65),
            txtColor: Colors.white,
            height: size.height),
      ),
      OnBoardingWidget(
        model: OnBoardingModel(
            image: "lib/images/onboarding_images/three.png",
            title: "Track You'r children",
            subTitile: "You'r childs information in your fingertips",
            counterText: "3/3",
            txtColor: Colors.white,
            bgColor: const Color.fromARGB(255, 255, 0, 0),
            height: size.height),
      )
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: LiquidSwipe(
              pages: pages,
              waveType: WaveType.circularReveal,
              onPageChangeCallback: OnPageChangeCallback,
              liquidController: controller,
              slideIconWidget: const Icon(Icons.arrow_back_ios),
              enableSideReveal: true,
            ),
          ),
          Positioned(
            bottom: 60.0,
            child: OutlinedButton(
              onPressed: () {
                if (controller.currentPage == 2) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                } else {
                  int nextPage = controller.currentPage + 1;
                  controller.animateToPage(page: nextPage);
                }
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black26),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20)),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color(0xff272727), shape: BoxShape.circle),
                child: const Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
          ),
          Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
                ),
              )),
          Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                activeIndex: controller.currentPage,
                count: 3,
                effect: const WormEffect(
                    activeDotColor: Color(0xff272727), dotHeight: 5.0),
              ))
        ],
      ),
    );
  }

  void OnPageChangeCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}
