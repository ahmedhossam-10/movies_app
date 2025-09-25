import 'package:flutter/material.dart';
import 'package:movies_app/onboarding_process.dart';
import 'package:movies_app/core/resources/ColorManager.dart';

import '../../../login/screen/login_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});
  static const String routeName = "onboarding";

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _controller = PageController();
  int currentPage = 0;
  final List<Map<String, String>> onboardingData = const [
    {
      "title": "Find Your Next\nFavorite Movie Here",
      "body": "Get access to a huge library of movies to suit all tastes.",
      "image": "assets/images/movies_posters.png"
    },
    {
      "title": "Discover Movies",
      "body": "Explore a vast collection of movies in all qualities and genres.",
      "image": "assets/images/avengers.png"
    },
    {
      "title": "Explore All Genres",
      "body": "Discover movies from every genre. Find something new and exciting.",
      "image": "assets/images/godfather.png"
    },
    {
      "title": "Create Watchlist",
      "body": "Save movies to your watchlist to keep track of what you want to watch next.",
      "image": "assets/images/badboys.png"
    },
    {
      "title": "Rate, Review and Learn",
      "body": "Share your thoughts on the movies you've watched and help others.",
      "image": "assets/images/drString.png"
    },
    {
      "title": "Start Watching Now",
      "body": "Enjoy movies anytime, anywhere!",
      "image": "assets/images/1917.png"
    },
  ];


  void _nextPage() {
    if (currentPage == onboardingData.length - 1) {
      _completeOnboarding();
    } else {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _backPage() {
    if (currentPage > 0) {
      _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _completeOnboarding() async {
    await OnboardingProcess.completeOnboarding();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, LogInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) => setState(() => currentPage = index),
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(data["image"]!),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    onboardingData[currentPage]["title"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    onboardingData[currentPage]["body"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  // زر Back
                  if (currentPage > 0)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _backPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.yellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text("Back",
                            style: TextStyle(color: Colors.black, fontSize: 18)),
                      ),
                    ),
                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.yellow,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        currentPage == onboardingData.length - 1
                            ? "Finish"
                            : "Next",
                        style: const TextStyle(
                            color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}