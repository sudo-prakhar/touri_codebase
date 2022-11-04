import 'package:flutter/material.dart';
import 'package:touri_frontend/features/home/bloc/services.dart';

import '../joystick.dart';

class RobotNavController extends StatelessWidget {
  const RobotNavController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppJoyStick(
            label: "Gimbal",
            onChanged: (details) {
              debugPrint("Gimabl x: ${details.x.toStringAsFixed(2)} y: ${details.y.toStringAsFixed(2)}"); //TODO: change
            },
            onRelease: () => TeleOpServices.resetManiValues(),
          ),
          AppJoyStick(
            label: "Robot",
            onChanged: (details) async {
              await TeleOpServices.updateRobotNavPos(-1 * details.x, -1 * details.y);
              debugPrint("Robot x: ${details.x.toStringAsFixed(2)} y: ${details.y.toStringAsFixed(2)}"); //TODO: change
            },
            onRelease: () => TeleOpServices.resetNavValues(),
          ),
        ],
      ),
    );
  }
}
