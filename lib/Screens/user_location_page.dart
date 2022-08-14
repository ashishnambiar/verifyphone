import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UserLocationPage extends StatelessWidget {
  static const String route = '/UserLocationPage';
  UserLocationPage({Key? key}) : super(key: key);
  final Location _location = Location();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Do you want to logout?'),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          child: const Text('YES')),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.popUntil(context,
                                (route) => !ModalRoute.of(context)!.isCurrent);
                          },
                          child: const Text('NO')),
                    ],
                  )
                ],
              ),
            );
          },
        );

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('User Location'),
          centerTitle: true,
        ),
        body: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(10, 10),
            zoom: 10,
          ),
          onMapCreated: (GoogleMapController controller) {
            _location.onLocationChanged.listen(
              (event) {
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(event.latitude!, event.longitude!),
                        zoom: 15),
                  ),
                );
              },
            );
          },
          mapType: MapType.normal,
          myLocationEnabled: true,
        ),
      ),
    );
  }
}
