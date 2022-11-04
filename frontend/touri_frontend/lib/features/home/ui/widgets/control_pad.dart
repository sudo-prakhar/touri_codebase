import 'package:flutter/cupertino.dart';
import 'package:touri_frontend/features/home/ui/widgets/contol_tabs/auto_commands.dart';

import 'contol_tabs/arm_controls.dart';
import 'contol_tabs/nav_controls.dart';
import 'controller_tab.dart';

class ControlPad extends StatefulWidget {
  const ControlPad({Key? key}) : super(key: key);

  @override
  State<ControlPad> createState() => _ControlPadState();
}

class _ControlPadState extends State<ControlPad> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ContollerTabs(
            index: index,
            onChanged: (int value) {
              setState(() {
                index = value;
              });
            },
          ),
          _buildChild(index),
        ],
      ),
    );
  }
}

Widget _buildChild(int index) {
  switch (index) {
    case 0:
      return const RobotNavController();
    case 1:
      return const RobotArmController(isGrabbing: false);
    case 2:
      return const RobotAutonomousCommands();
    default:
      return const Text("Default");
  }
}
