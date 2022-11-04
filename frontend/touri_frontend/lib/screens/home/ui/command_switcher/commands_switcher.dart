// import 'package:flutter/material.dart';
// import 'package:touri_frontend/screens/home/ui/autonomous_options/autonomous_options.dart';
// import 'package:touri_frontend/screens/home/ui/joystick/teleop_joystick.dart';

// class CommandSwitcher extends StatelessWidget {
//   final bool isTeleop;
//   const CommandSwitcher({
//     Key? key,
//     required this.isTeleop,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 300),
//         transitionBuilder: (Widget child, Animation<double> animation) {
//           return ScaleTransition(scale: animation, child: child);
//         },
//         child: isTeleop
//             ? TeleopJoystick(
//                 onChanged: (_) {}, //TODO: Add bloc logic
//                 onRelease: () {}, //TODO: Add bloc logic
//               )
//             : Padding(
//                 padding: const EdgeInsets.only(bottom: 100.0),
//                 child: AutonomousOptionsListView(
//                   commandList: const ["CMD 1", "CMD 1", "CMD 1", "CMD 1", "CMD 1", "CMD 1"],
//                 ),
//               ),
//       ),
//     );
//   }
// }
