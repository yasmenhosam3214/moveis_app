// import 'package:flutter/material.dart';
// import 'package:moveis_app/core/uitls/app_colors.dart';
//
// class CastCard extends StatelessWidget {
//   final String name;
//   final String role;
//   final String img;
//   final String rating;
//
//   const CastCard({
//     super.key,
//     required this.name,
//     required this.role,
//     required this.img,
//     required this.rating,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: AppColors.gray,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Image.network(img, height: 80, width: 80, fit: BoxFit.cover),
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 role,
//                 style: const TextStyle(color: AppColors.white, fontSize: 18),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
