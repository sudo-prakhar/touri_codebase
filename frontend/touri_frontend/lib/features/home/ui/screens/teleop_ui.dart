import 'package:flutter/material.dart';
import 'package:touri_frontend/features/home/ui/video_call.dart/voip.dart';
import 'package:touri_frontend/features/home/ui/widgets/control_pad.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: const [
            Center(child: VoipFrame()),
            ControlPad(),
          ],
        ),
      ),
    );
  }
}
