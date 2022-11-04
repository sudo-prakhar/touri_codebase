import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CameraDisplay();
    // return Container();
  }
}

class CameraDisplay extends StatefulWidget {
  const CameraDisplay({Key? key}) : super(key: key);

  @override
  _CameraDisplayState createState() => _CameraDisplayState();
}

class _CameraDisplayState extends State<CameraDisplay> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    initCam();
  }

  Future<void> initCam() async {
    final List cameras = await availableCameras();
    controller = CameraController(cameras[1], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return Container();
    } else {
      return Center(
        child: CameraPreview(controller!),
      );
    }
  }
}
