// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:touri_frontend/features/home/ui/video_call.dart/voip.dart';

Autonomy manipulation = Autonomy(name: "Manipulation", commandId: "mani_auto", teleopId: "mani_tele");
Autonomy navigation = Autonomy(name: "Navigation", commandId: "mani_auto", teleopId: "mani_tele");
Autonomy gimbal = Autonomy(name: "Gimbal", commandId: "mani_auto", teleopId: "mani_tele");

class PhoneHomeUI extends StatefulWidget {
  const PhoneHomeUI({Key? key}) : super(key: key);

  @override
  State<PhoneHomeUI> createState() => _PhoneHomeUIState();
}

class _PhoneHomeUIState extends State<PhoneHomeUI> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: VoipFrame()),
        PageView(
          scrollDirection: Axis.vertical,
          controller: controller,
          children: [
            PhoneHomeScreen(autonomy: navigation),
            PhoneHomeScreen(autonomy: manipulation),
            PhoneHomeScreen(autonomy: gimbal),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SmoothPageIndicator(
              controller: controller, // PageController
              count: 3,
              axisDirection: Axis.vertical,
              effect: SlideEffect(
                spacing: 8.0,
                dotHeight: 8,
                dotWidth: 8,
                strokeWidth: 1,
                dotColor: Colors.grey,
                activeDotColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//______________________________________________________________________________________________________________________

class Autonomy {
  final String name;
  final String commandId;
  final String teleopId;

  Autonomy({
    required this.name,
    required this.commandId,
    required this.teleopId,
  });
}

//______________________________________________________________________________________________________________________
class PhoneHomeScreen extends StatefulWidget {
  final Autonomy autonomy;
  PhoneHomeScreen({Key? key, required this.autonomy}) : super(key: key);

  @override
  State<PhoneHomeScreen> createState() => _PhoneHomeScreenState();
}

class _PhoneHomeScreenState extends State<PhoneHomeScreen> {
  bool showCommands = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFAB(),
      appBar: AppBar(
        title: Text(widget.autonomy.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: showCommands ? CommandsList() : TeleopJoystickArea(),
      ),
    );
  }

  Widget buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          showCommands = !showCommands;
        });
      },
      child: Icon(showCommands ? Icons.add : Icons.remove),
    );
  }
}

//______________________________________________________________________________________________________________________

class TeleopJoystickArea extends StatelessWidget {
  const TeleopJoystickArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JoystickArea(
      listener: (details) {},
      period: const Duration(milliseconds: 100),
    );
  }
}

//______________________________________________________________________________________________________________________

//______________________________________________________________________________________________________________________
class AutonomousCommand {
  final String label;
  final String imgSrc;
  final String id;

  AutonomousCommand({
    required this.label,
    this.imgSrc = "",
    required this.id,
  });
}

class AutonomousCommandTile extends StatelessWidget {
  const AutonomousCommandTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        width: 100,
        alignment: Alignment.center,
        child: Text("Hello"),
      ),
    );
  }
}

class CommandsList extends StatelessWidget {
  CommandsList({Key? key}) : super(key: key);

  final dummyList = ["One", "Two", "Three", "One", "Two", "Three"];
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 100),
        height: 80,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dummyList.length,
            itemBuilder: (context, index) {
              return AutonomousCommandTile();
            }),
      ),
    );
  }
}
