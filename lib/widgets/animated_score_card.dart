// import 'package:flutter/material.dart';

// class AnimatedScoreCard extends StatelessWidget {
//   final String score;
//   final Duration duration;
//   final Animation<double> animation;

//   const AnimatedScoreCard({
//     Key? key,
//     required this.score,
//     required this.duration,
//     required this.animation,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, child) {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Text(
//             score,
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
