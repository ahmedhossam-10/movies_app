import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:movies_app/home_page.dart';
import 'package:movies_app/onboarding_process.dart';
import 'package:movies_app/core/resources/ColorManager.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  void _completeOnboarding(BuildContext context) async {
    await OnboardingProcess.completeOnboarding();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) =>  HomePage()),
    );
  }

  final List<Map<String, String>> onboardingData = const [
    {
      "title": "Find Your Next\nFavorite Movie Here",
      "body": "Get access to a huge library of movies\n to suit all tastes. You will surely like it",
      "image": "assets/images/movies_posters.png"
    },
    {
      "title": "Discover Movies",
      "body": "Explore a vast collection of movies in all\n qualities and genres. Find your next\n favorite film with ease.",
      "image": "assets/images/avengers.png"
    },
    {
      "title": "Explore All Genres",
      "body": "Discover movies from every genre, in all\n available qualities. Find something new\n and exciting to watch every day.",
      "image": "assets/images/godFather.png"
    },
    {
      "title": "Create Watchlist",
      "body": "Save movies to your watchlist to keep\n track of what you want to watch next.",
      "image": "assets/images/badBoys.png"
    },
    {
      "title": "Rate, Review and Learn",
      "body": "Share your thoughts on the movies\n you've watched and help others.",
      "image": "assets/images/drString.png"
    },
  ];

  static get routeName => null;

  List<PageViewModel> buildPages(BuildContext context) {
    return onboardingData.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, String> data = entry.value;

      return PageViewModel(
        titleWidget: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.black.withOpacity(0.5),
          child: Column(
            children: [
              Text(
                data["title"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                data["body"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
        image: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(data["image"]!, fit: BoxFit.cover),
          ],
        ),
        footer: index == onboardingData.length - 1
            ? ElevatedButton(
          onPressed: () => _completeOnboarding(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManger.yellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          child: const Text(
            "Start",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
            : null,
        decoration: const PageDecoration(
          pageColor: Colors.transparent,
          imagePadding: EdgeInsets.zero,
          bodyPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.black,
        pages: buildPages(context),
        showSkipButton: true,
        skip: Text("Skip", style: TextStyle(color: ColorManger.white)),
        next: Icon(Icons.arrow_forward, color: ColorManger.yellow),
        done: Text("Done", style: TextStyle(color: ColorManger.white)),
        onDone: () => _completeOnboarding(context),
        dotsDecorator: const DotsDecorator(
          activeColor: Colors.white,
          color: Colors.white54,
          size: Size(8, 8),
          activeSize: Size(12, 12),
        ),
      ),
    );
  }
}
