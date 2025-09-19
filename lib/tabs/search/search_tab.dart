import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  static const String routeName = "/search";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        "assets/icons/Vector (search).png",
                        width: 20,
                        height: 20,
                        color: Colors.white54,
                      ),
                    ),
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Center(
                  child: Image.asset(
                    "assets/images/logosearch.png",
                    width: 124,
                    height: 124,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
