import 'package:flutter/material.dart';
import 'package:moveis_app/onboarding/page_view_items.dart';
import 'onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "/onboarding";

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _handleButton(String buttonText) {
    if (buttonText == "Next" || buttonText == "Explore New") {
      if (_currentPage < onboardingList.length - 1) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    } else if (buttonText == "Back") {
      if (_currentPage > 0) {
        _controller.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    } else if (buttonText == "Finish") {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingList.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return PageViewItem(
            item: onboardingList[index],
            onButtonPressed: _handleButton,
          );
        },
      ),
    );
  }
}
