import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// class MyHomePage extends StatelessWidget {
//   final GlobalKey repaintKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Widget to Image'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             RepaintBoundary(
//               key: repaintKey,
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 color: Colors.blue,
//                 child: Center(
//                   child: Text(
//                     'Hello!',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _captureAndShowImage(context),
//               child: Text('Convert to Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _captureAndShowImage(BuildContext context) async {
//     try {
//       RenderRepaintBoundary boundary = repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       Uint8List pngBytes = byteData!.buffer.asUint8List();

//       print('Image Byte Size: ${pngBytes.length} bytes');
//     } catch (e) {
//       print('Error capturing image: $e');
//     }
//   }
// }



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey repaintKey = GlobalKey();
  Uint8List? capturedBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget to Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: repaintKey,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Hello!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _captureAndShowImage(context),
              child: const Text('Convert and Show Image'),
            ),
            const SizedBox(height: 20),
            if (capturedBytes != null) Image.memory(capturedBytes!),
          ],
        ),
      ),
    );
  }

  Future<void> _captureAndShowImage(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary = repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      // Update the state to display the captured image
      setState(() {
        capturedBytes = pngBytes;
      });
    } catch (e) {
      print('Error capturing image: $e');
    }
  }
}