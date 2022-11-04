import 'package:flutter/material.dart';
import 'package:touri_frontend/screens/home/home_main.dart';

class SplashUI extends StatelessWidget {
  const SplashUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(width: double.infinity),
            //IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset("assets/app_icon/logo.png", height: 200),
            ),
            //DIVIDER
            SizedBox(height: 30),
            //TEXT
            const Text(
              "TouRI",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600, color: Colors.white70),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeMain())),
              child: Text("START"),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(122, 11, 22, 1),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
