import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:touri_frontend/phone/ui/pages/home/iphone_home.dart';
import 'package:touri_frontend/screens/home/home_main.dart';
import 'package:touri_frontend/screens/splash/splash_main.dart';

import 'features/home/ui/screens/teleop_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TouriApp());
}

class TouriApp extends StatelessWidget {
  const TouriApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Touri",
      theme: ThemeData.dark(),
      home: SplashUI(),
    );
  }
}

class FailSafeUI extends StatefulWidget {
  const FailSafeUI({Key? key}) : super(key: key);

  @override
  State<FailSafeUI> createState() => _FailSafeUIState();
}

class _FailSafeUIState extends State<FailSafeUI> {
  bool isKilled = false;

  @override
  Widget build(BuildContext context) {
    // Return a Scaffold with a column and two buttons
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: isKilled ? const Text("RESET") : const Text("KILL"),
          style: ElevatedButton.styleFrom(
            primary: isKilled ? Colors.blueGrey : Colors.red,
          ),
          onPressed: () async {
            int pos = isKilled ? 0 : 180;
            await updateEEPos(pos);
            setState(() {
              isKilled = !isKilled;
            });
          },
        ),
      ),
    );
  }
}

Future<void> updateEEPos(int pos) async {
  final DatabaseReference db = FirebaseDatabase.instance.ref();
  db.update({"ee_pos": pos});
}
