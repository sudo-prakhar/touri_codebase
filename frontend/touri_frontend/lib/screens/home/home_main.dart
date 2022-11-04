import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

import 'package:touri_frontend/screens/home/repo/db_services.dart';
import 'package:touri_frontend/screens/home/ui/animated_fab/animated_fab.dart';
import 'package:touri_frontend/screens/home/ui/autonomous_options/autonomous_options.dart';
import 'package:touri_frontend/screens/home/ui/joystick/teleop_joystick.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: FirebaseDatabase.instance.ref('misc').child("is_teleop_mode").onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DatabaseEvent a = snapshot.data as DatabaseEvent;
          bool isTeleop = a.snapshot.value as bool;
          return _HomeMain(isTeleop: isTeleop);
        }
        return Container();
      },
    );
  }
}

//___________________________________________________________________________________________

class _HomeMain extends StatelessWidget {
  final bool isTeleop;
  _HomeMain({
    Key? key,
    required this.isTeleop,
  }) : super(key: key);

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'BASE'),
    Tab(text: 'ARM'),
    Tab(text: 'FACE'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        // APP BAR
        appBar: AppBar(
          title: Text("TOURI"),
          titleTextStyle: TextStyle(
            fontSize: 55,
            color: Colors.white.withOpacity(0.1),
            fontWeight: FontWeight.bold,
          ),
          bottom: TabBar(tabs: myTabs),
          actions: const [HomeRobotButton(), StowRobotButton(), KillButton()],
        ),
        // BODY
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // BASE
            HomeBody(
              onTeleop: (details) => NavigationServices.teleop(details.x, details.y),
              onJoyStickReleased: () => NavigationServices.resetNavValues(),
              getCmdList: () => NavigationServices.getRooms(),
              onCmdSelected: (roomNum) => NavigationServices.selectRoom(roomNum!),
              isTeleop: isTeleop,
            ),
            // ARM
            HomeBody(
              onTeleop: (details) => ManipulationServices.teleop(details.x, details.y),
              onJoyStickReleased: () => ManipulationServices.resetManipulatorValues(),
              getCmdList: () => ManipulationServices.getObject(),
              onCmdSelected: (objectId) => ManipulationServices.selectObject(objectId!),
              child: ManipulatinChild(),
              isTeleop: isTeleop,
            ),
            // FACE
            HomeBody(
              onTeleop: (details) => HardwareServices.teleop(details.x, details.y),
              onJoyStickReleased: () => HardwareServices.resetGimbalValues(),
              getCmdList: () => HardwareServices.getOptions(),
              onCmdSelected: (_) {},
              // child: DetectObjectsButton(),
              isTeleop: isTeleop,
            ),
          ],
        ),
      ),
    );
  }
}

//___________________________________________________________________________________________

class HomeBody extends StatefulWidget {
  final Function(StickDragDetails details) onTeleop;
  final VoidCallback onJoyStickReleased;
  final Function getCmdList;
  final Function(String? cmdId) onCmdSelected;
  final bool isTeleop;
  final Widget? child;

  const HomeBody({
    Key? key,
    required this.onTeleop,
    required this.onJoyStickReleased,
    required this.getCmdList,
    required this.onCmdSelected,
    required this.isTeleop,
    this.child,
  }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedFAB(
        isTeleopMode: widget.isTeleop,
        onPressed: () => FirebaseDatabase.instance.ref('misc').update({"is_teleop_mode": !widget.isTeleop}),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // EXPAND WIDGET
          SizedBox(width: double.infinity),
          // BODY
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: widget.isTeleop
                ? TeleopJoystick(
                    onChanged: (details) => widget.onTeleop(details),
                    onRelease: widget.onJoyStickReleased,
                  )
                : AutonomousCommands(
                    onCmdSelected: (cmdId) => widget.onCmdSelected(cmdId),
                    getCmdList: widget.getCmdList,
                  ),
          ),
          // CHILD
          if (widget.isTeleop) ...[widget.child ?? Container()]
        ],
      ),
    );
  }
}

//______________________________________________________________________________________________________________

class ManipulatinChild extends StatelessWidget {
  const ManipulatinChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () => ManipulationServices.grasp(false),
          child: Text("OPEN GRIPPER"),
        ),
        TextButton(
          onPressed: () => ManipulationServices.grasp(true),
          child: Text("CLOSE GRIPPER"),
        ),
      ],
    );
  }
}

//______________________________________________________________________________________________________________

class DetectObjectsButton extends StatelessWidget {
  const DetectObjectsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => PerceptionServices.requestDetection(),
      child: Text("DETECT OBJECTS"),
    );
  }
}

//______________________________________________________________________________________________________________

class KillButton extends StatefulWidget {
  const KillButton({Key? key}) : super(key: key);

  @override
  State<KillButton> createState() => _KillButtonState();
}

class _KillButtonState extends State<KillButton> {
  bool isKilled = false;

  @override
  Widget build(BuildContext context) {
    return isKilled
        ? TextButton(
            onPressed: () {
              HardwareServices.release();
              setState(() {
                isKilled = !isKilled;
              });
            },
            child: Text("RELEASE"),
          )
        : TextButton(
            onPressed: () {
              HardwareServices.kill();
              setState(() {
                isKilled = !isKilled;
              });
            },
            style: TextButton.styleFrom(primary: Colors.red),
            child: Text("KILL"),
          );
  }
}

//______________________________________________________________________________________________________________

class HomeRobotButton extends StatelessWidget {
  const HomeRobotButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text("HOME"),
      onPressed: () => FirebaseDatabase.instance.ref('misc').update({"home_requested": true}),
    );
  }
}
//______________________________________________________________________________________________________________

class StowRobotButton extends StatelessWidget {
  const StowRobotButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text("STOW"),
      onPressed: () => FirebaseDatabase.instance.ref('misc').update({"stow_requested": true}),
    );
  }
}
