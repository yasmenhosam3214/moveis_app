import 'package:flutter/material.dart';
import 'package:moveis_app/core/uitls/app_colors.dart';

Widget buildBottomStat(IconData icon, String text) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, color: Colors.yellow, size: 20),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    ),
  );
}
