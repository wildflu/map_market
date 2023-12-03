import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'compoents/widget_image.dart';

void main() {
  runApp(const GetMaterialApp(
    home: MyApp(),
    title: 'Home Ppp',
  ));
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = {};

  late BitmapDescriptor customIcon;

  Future<void> _loadCustomIcon() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      'assets/ball.png',
    );
    setState(() {});
    _addMarkers();
  }

  void _addMarkers() {
    setState(() {
      markers = {
        const Marker(
          markerId: MarkerId('marker1'),
          position: LatLng(32.29430357189937, -9.242994859814644),
          infoWindow: InfoWindow(
            title: 'Title 1',
            snippet: 'Snippet 1',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
        Marker(
          markerId: const MarkerId('marker2'),
          position: const LatLng(32.28907103303258, -9.244076460599901),
          infoWindow: const InfoWindow(
            title: 'Title 2',
            snippet: 'Snippet 2',
          ),
          icon: customIcon,
        ),
        const Marker(
          markerId: MarkerId('marker3'),
          position: LatLng(32.294902423543036, -9.238837100565434),
          infoWindow: InfoWindow(
            title: 'Title 3',
            snippet: 'Snippet 3',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      };
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
  }



  // Set<Marker> markers = {
  //   const Marker(
  //     markerId: MarkerId('just test'),
  //     position: LatLng(32.29430357189937, -9.242994859814644),
  //     infoWindow: InfoWindow(
  //       title: 'title',
  //       snippet: 'snippet',
  //     ),
  //     icon: BitmapDescriptor.defaultMarker,
  //   ),
  //   const Marker(
  //     markerId: MarkerId('just test'),
  //     position: LatLng(32.28907103303258, -9.244076460599901),
  //     infoWindow: InfoWindow(
  //       title: 'title',
  //       snippet: 'snippet',
  //     ),
  //     icon: customIcon,
  //   ),
  //   const Marker(
  //     markerId: MarkerId('just test'),
  //     position: LatLng(32.294902423543036, -9.238837100565434),
  //     infoWindow: InfoWindow(
  //       title: 'title',
  //       snippet: 'snippet',
  //     ),
  //     icon: BitmapDescriptor.defaultMarker,
  //   )
  // };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()=>Get.to(()=> MyHomePage()), icon: const Icon(Icons.next_plan))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: const CameraPosition(target: LatLng(888, 776)),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onTap: (argument) {
                  print('this is the lat ${argument.latitude}');
                  print('this is the lon ${argument.longitude}');
                },
                markers: markers,
            ),
      ),
    );
  }
}