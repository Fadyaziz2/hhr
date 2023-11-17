import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VisitDetailsGoogleMap extends StatelessWidget {
  const VisitDetailsGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
      return GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(target: LatLng(23.791901, 90.426801), zoom: 14.4746),
        // markers: Set<Marker>.of(provider.markers),
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          // provider.mapController.complete(controller);
        },
      );

  }
}
