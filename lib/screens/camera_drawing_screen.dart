import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CameraDrawingScreen extends StatefulWidget {
  const CameraDrawingScreen({super.key});

  @override
  _CameraDrawingScreenState createState() => _CameraDrawingScreenState();
}

class _CameraDrawingScreenState extends State<CameraDrawingScreen> {
  late ArCoreController arCoreController;
  Color selectedColor = Colors.red;

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addSphere(hit.pose.translation, hit.pose.rotation);
  }

  void _addSphere(vector.Vector3 position, vector.Vector4 rotation) {
    final material = ArCoreMaterial(color: selectedColor);
    final sphere = ArCoreSphere(materials: [material], radius: 0.05);
    final node = ArCoreNode(
      shape: sphere,
      position: position,
      rotation: rotation,
    );
    arCoreController.addArCoreNodeWithAnchor(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () {
                    setState(() {
                      selectedColor = Colors.red;
                    });
                  },
                ),
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    setState(() {
                      selectedColor = Colors.green;
                    });
                  },
                ),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    setState(() {
                      selectedColor = Colors.blue;
                    });
                  },
                ),
                FloatingActionButton(
                  backgroundColor: Colors.yellow,
                  onPressed: () {
                    setState(() {
                      selectedColor = Colors.yellow;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
