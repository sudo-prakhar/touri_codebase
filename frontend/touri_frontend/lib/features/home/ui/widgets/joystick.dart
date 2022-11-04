import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class AppJoyStick extends StatelessWidget {
  final String label;
  final Function(StickDragDetails details) onChanged;
  final Function onRelease;

  const AppJoyStick({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.onRelease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerUp: (_) => onRelease(),
          child: Joystick(
            listener: (details) => onChanged(details),
            period: const Duration(milliseconds: 100),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
