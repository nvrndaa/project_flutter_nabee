// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class HomePageLogin extends StatelessWidget {
//   const HomePageLogin({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       bottomNavigationBar: Container(
//         height: 75,
//         margin: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: const Color(0xFFE28A24),
//           borderRadius: BorderRadius.circular(40),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _navItem("assets/icons/nav/home.svg", "Home", true),
//             _navItem("assets/icons/nav/honey_jar.svg", "Honey Jar", false),
//             _navItem("assets/icons/nav/profile.svg", "Profile", false),
//           ],
//         ),
//       ),

//       body: SafeArea(
//         child: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               right: 0,
//               child: Opacity(
//                 opacity: 0.3,
//                 child: Image.asset("assets/images/sarang_lebah_atas.png", width: 140),
//               ),
//             ),

//             SingleChildScrollView(
//               padding: const EdgeInsets.all(16),

//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,

//                 children: [
//                   /// HEADER
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Hi, Salmaa!",
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF4E1F0F),
//                         ),
//                       ),

//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                           color: Color(0xFFE28A24),
//                           shape: BoxShape.circle,
//                         ),
//                         child: SvgPicture.asset(
//                           "assets/icons/notif.svg",
//                           width: 18,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 16),

//                   /// STAT CARD
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _statCard(
//                           icon: "assets/icons/target_salved.svg",
//                           title: "Target solved",
//                           value: "1 Jars",
//                         ),
//                       ),

//                       const SizedBox(width: 12),

//                       Expanded(
//                         child: _statCard(
//                           icon: "assets/icons/coin.svg",
//                           title: "Money saved",
//                           value: "500 Rupiah",
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 18),

//                   /// CHARACTER CARD
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF8E9B7),
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           "assets/images/babybee_happy.png",
//                           height: 180,
//                         ),

//                         const SizedBox(height: 8),

//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 28,
//                             vertical: 8,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(color: const Color(0xFFE28A24)),
//                           ),
//                           child: const Text(
//                             "Windah",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   /// TARGET
//                   const Text(
//                     "Nearest Target",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF4E1F0F),
//                     ),
//                   ),

//                   const SizedBox(height: 10),

//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF7E68E),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.asset(
//                             "assets/images/empty_jar.png",
//                             width: 70,
//                             height: 70,
//                             fit: BoxFit.cover,
//                           ),
//                         ),

//                         const SizedBox(width: 12),

//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "New year bali trip",
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),

//                               const SizedBox(height: 8),

//                               Container(
//                                 height: 10,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: FractionallySizedBox(
//                                   widthFactor: 0.3,
//                                   alignment: Alignment.centerLeft,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFFE28A24),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               const SizedBox(height: 4),

//                               const Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Text(
//                                   "15/500.000",
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         const Icon(Icons.chevron_right),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   /// HONEY TIPS
//                   const Text(
//                     "Honey tips",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF4E1F0F),
//                     ),
//                   ),

//                   const SizedBox(height: 10),

//                   _tipsCard(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _statCard({
//     required String icon,
//     required String title,
//     required String value,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFFE28A24)),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           SvgPicture.asset(icon, width: 20),

//           const SizedBox(width: 8),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: const TextStyle(fontSize: 10)),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     color: Color(0xFFE28A24),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _tipsCard() {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFF3EEDB),
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(18),
//             child: Image.asset(
//               "assets/images/bee.png",
//               width: 90,
//               height: 90,
//               fit: BoxFit.cover,
//             ),
//           ),

//           const Expanded(
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Economic Growth",
//                     style: TextStyle(color: Colors.orange, fontSize: 10),
//                   ),

//                   SizedBox(height: 4),

//                   Text(
//                     "Money matters: Your guide to financial literacy",
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),

//                   SizedBox(height: 4),

//                   Text("World Economic Forum", style: TextStyle(fontSize: 11)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _navItem(String icon, String label, bool active) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SvgPicture.asset(icon, width: 22),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             color: active ? Colors.white : Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }
