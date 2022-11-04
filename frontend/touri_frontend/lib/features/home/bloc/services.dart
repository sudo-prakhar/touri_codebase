import 'package:firebase_database/firebase_database.dart';

abstract class TeleOpServices {
  static Future<void> updateRobotNavPos(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    db.update({
      "nav": {"x": xVal, "y": yVal},
    });
  }

  static Future<void> updateRobotManiPos(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    db.update({
      "mani": {"height": yVal, "extend": xVal}
    });
  }

  static Future<void> performSkill(String skillId) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    db.update({
      "skill_req": {"id": skillId, "inProgress": true}
    });
  }

  static Future<void> resetNavValues() async {
    await updateRobotNavPos(0, 0);
  }

  static Future<void> resetManiValues() async {
    await updateRobotManiPos(0, 0);
  }
}
