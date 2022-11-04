import 'package:flutter/material.dart';
import 'package:touri_frontend/features/home/bloc/services.dart';

import '../joystick.dart';

class RobotArmController extends StatelessWidget {
  final bool isGrabbing;
  const RobotArmController({
    Key? key,
    required this.isGrabbing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //___________________________________________________________________________________________________________
          AppJoyStick(
            label: "Gimbal",
            onChanged: (details) {
              debugPrint(
                  "Vertical x: ${details.x.toStringAsFixed(2)} y: ${details.y.toStringAsFixed(2)}"); //TODO: change
            },
            onRelease: () => TeleOpServices.resetManiValues(),
          ),
          //___________________________________________________________________________________________________________
          ElevatedButton(
            child: Text(
              isGrabbing ? "UNGRAB" : "GRAB",
              style: const TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {},
          ),
          //___________________________________________________________________________________________________________
          AppJoyStick(
            label: "MANIPULATOR",
            onChanged: (details) async {
              await TeleOpServices.updateRobotManiPos(-1 * details.x, -1 * details.y);
              debugPrint("Robot x: ${details.x.toStringAsFixed(2)} y: ${details.y.toStringAsFixed(2)}"); //TODO: change
            },
            onRelease: () => TeleOpServices.resetManiValues(),
          ),
          //___________________________________________________________________________________________________________
        ],
      ),
    );
  }
}
