import 'package:flutter/material.dart';
import 'onboarding_data.dart';

class PageViewItem extends StatelessWidget {
  final OnboardingData item;
  final Function(String) onButtonPressed;

  const PageViewItem({
    Key? key,
    required this.item,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(item.imageName, fit: BoxFit.cover),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  Text(
                    item.description,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  Column(
                    children: item.buttons.map((button) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () => onButtonPressed(button.text),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: button.backgroundColor,
                            foregroundColor: button.textColor,
                            side: BorderSide(
                              color: button.borderColor,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            button.text,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: button.textColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
