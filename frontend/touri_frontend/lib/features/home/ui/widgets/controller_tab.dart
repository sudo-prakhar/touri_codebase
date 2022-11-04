import 'package:flutter/cupertino.dart';

class ContollerTabs extends StatelessWidget {
  final int index;
  final Function(int value) onChanged;
  const ContollerTabs({
    Key? key,
    required this.index,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoSlidingSegmentedControl(
        groupValue: index,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children: const {
          0: _ControllerLabel(label: "Navigation"),
          1: _ControllerLabel(label: "Manipulator"),
          2: _ControllerLabel(label: "Commands"),
        },
        onValueChanged: (int? value) => onChanged(value ?? 0),
      ),
    );
  }
}

class _ControllerLabel extends StatelessWidget {
  final String label;
  const _ControllerLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(label),
    );
  }
}
