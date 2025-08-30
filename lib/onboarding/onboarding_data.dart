import 'package:flutter/material.dart';

class OnboardingButton {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;

  OnboardingButton({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });
}

class OnboardingData {
  final String imageName;
  final String title;
  final String description;
  final List<OnboardingButton> buttons;

  OnboardingData({
    required this.imageName,
    required this.title,
    required this.description,
    required this.buttons,
  });
}

List<OnboardingData> onboardingList = [
  OnboardingData(
    imageName: "assets/images/onboarding1.png",
    title: "Find Your Next \nFavorite Movie Here",
    description:
        "Get access to a huge library of movies to suit all tastes. You will surely like it.",
    buttons: [
      OnboardingButton(
        text: "Explore New",
        textColor: Colors.black,
        backgroundColor: const Color(0xFFF6BD00),
        borderColor: const Color(0xFFF6BD00),
      ),
    ],
  ),
  OnboardingData(
    imageName: "assets/images/onboarding2.png",
    title: "Discover Movies",
    description:
        "Explore a vast collection of movies in all \nqualities and genres. Find your next \nfavorite film with ease.",
    buttons: [
      OnboardingButton(
        text: "Next",
        textColor: Colors.black,
        backgroundColor: const Color(0xFFF6BD00),
        borderColor: const Color(0xFFF6BD00),
      ),
    ],
  ),
  OnboardingData(
    imageName: "assets/images/onboarding3.png",
    title: "Explore All Genres",
    description:
        "Discover movies from every genre, in all \navailable qualities. Find something new \nand exciting to watch every day.",
    buttons: [
      OnboardingButton(
        text: "Next",
        textColor: Colors.black,
        backgroundColor: const Color(0xFFF6BD00),
        borderColor: const Color(0xFFF6BD00),
      ),
      OnboardingButton(
        text: "Back",
        textColor: const Color(0xFFF6BD00),
        backgroundColor: Colors.black,
        borderColor: const Color(0xFFF6BD00),
      ),
    ],
  ),
  OnboardingData(
    imageName: "assets/images/onbording4.png",
    title: "Create Watchlists",
    description:
        "Save movies to your watchlist to keep \ntrack of what you want to watch next.\n Enjoy films in various qualities and \ngenres.",
    buttons: [
      OnboardingButton(
        text: "Next",
        textColor: Colors.black,
        backgroundColor: const Color(0xFFF6BD00),
        borderColor: const Color(0xFFF6BD00),
      ),
      OnboardingButton(
        text: "Back",
        textColor: const Color(0xFFF6BD00),
        backgroundColor: Colors.black,
        borderColor: const Color(0xFFF6BD00),
      ),
    ],
  ),
  OnboardingData(
    imageName: "assets/images/onbording5.png",
    title: "Rate, Review, and Learn",
    description:
        "Share your thoughts on the movies\n you've watched. Dive deep into film \ndetails and help others discover great \n movies with your reviews.",
    buttons: [
      OnboardingButton(
        text: "Next",
        textColor: Colors.black,
        backgroundColor: const Color(0xFFF6BD00),
        borderColor: const Color(0xFFF6BD00),
      ),
      OnboardingButton(
        text: "Back",
        textColor: const Color(0xFFF6BD00),
        backgroundColor: Colors.black,
        borderColor: const Color(0xFFF6BD00),
      ),
    ],
  ),
  OnboardingData(
    imageName: "assets/images/onbording6.png",
    title: "Start Watching Now",
    description: "",
    buttons: [
      OnboardingButton(
        text: "Finish",
        textColor: Colors.black,
        backgroundColor: const Color(0xFFF6BD00),
        borderColor: const Color(0xFFF6BD00),
      ),
      OnboardingButton(
        text: "Back",
        textColor: const Color(0xFFF6BD00),
        backgroundColor: Colors.black,
        borderColor: const Color(0xFFF6BD00),
      ),
    ],
  ),
];
