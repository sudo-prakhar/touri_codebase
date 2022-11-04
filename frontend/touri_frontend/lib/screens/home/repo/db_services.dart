import 'package:firebase_database/firebase_database.dart';

abstract class NavigationServices {
  //TELEOP
  static Future<void> teleop(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    db.child("nav").update({"x": xVal, "y": -yVal});
  }

  //RESET TELEOP

  static Future<void> resetNavValues() async {
    await teleop(0, 0);
  }

  // SELECT ROOM
  static Future<void> selectRoom(String roomNum) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    await db.child("nav").update({"room_num": roomNum});
    await Future.delayed(Duration(seconds: 3));
    await db.child("nav").update({"room_num": "None"});
  }

  // GET ROOM NUMS
  static Future<List<String>> getRooms() async {
    await Future.delayed(Duration(milliseconds: 100));
    return ['room 3108', 'room 3109', 'room 3110', 'room 3111'];
  }
}

//____________________________________________________________________________________

abstract class ManipulationServices {
  //TELEOP
  static Future<void> teleop(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    db.child("mani").update({"x": xVal, "y": -yVal});
  }

  //RESET TELEOP
  static Future<void> resetManipulatorValues() async {
    await teleop(0, 0);
  }

  // SELECT OBJECT
  static Future<void> selectObject(String selectedObject) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    await db.child("mani").update({"object": selectedObject});
    await Future.delayed(Duration(seconds: 3));
    await db.child("mani").update({"object": "None"});
  }

  // GET OBJECTS
  static Future<List> getObject() async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    DataSnapshot response = await db.child("/objects/detected_objs").get();
    List objects = response.value as List;
    List<String> objectsList = List<String>.from(objects);
    objectsList.add("DEGRASP");
    return objectsList;
  }

  // GRASP
  static Future<void> grasp(bool grasp) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    await db.update({"mani/grasp": grasp});
  }
}

//_________________________________________________________________________________________

abstract class PerceptionServices {
  static Future<void> requestDetection() async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    await db.child("objects").update({"request_detection": true});
    await Future.delayed(Duration(seconds: 3));
    await db.child("objects").update({"request_detection": false});
  }
}

abstract class HardwareServices {
  static Future<void> kill() async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    await db.update({"/ee_pos": 0});
    await Future.delayed(Duration(milliseconds: 500));
    await db.update({"/ee_pos": 80});
  }

  static Future<void> release() async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    await db.update({"/ee_pos": 0});
    await Future.delayed(Duration(milliseconds: 2500));
    await db.update({"/ee_pos": 80});
  }

  //TELEOP
  static Future<void> teleop(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    db.child("gimbal").update({"x": xVal, "y": -yVal});
  }

  //RESET TELEOP
  static Future<void> resetGimbalValues() async {
    await teleop(0, 0);
  }

  // GET ROOM NUMS
  static Future<List<String>> getOptions() async {
    await Future.delayed(Duration(milliseconds: 100));
    return ['Hardware options'];
  }
}
