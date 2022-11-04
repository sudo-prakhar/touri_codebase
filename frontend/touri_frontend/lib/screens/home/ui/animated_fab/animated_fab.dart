import 'package:flutter/material.dart';

class AnimatedFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isTeleopMode;

  const AnimatedFAB({
    Key? key,
    required this.onPressed,
    required this.isTeleopMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: isTeleopMode ? Colors.brown : Colors.purple,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: isTeleopMode
            ? Icon(
                Icons.menu,
                color: Colors.white,
                key: ValueKey(1),
              )
            : Icon(
                Icons.gamepad_rounded,
                color: Colors.white,
                key: ValueKey(2),
              ),
      ),
      onPressed: onPressed,
    );
  }
}
