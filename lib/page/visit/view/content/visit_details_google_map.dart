import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../bloc/visit_bloc.dart';

class VisitDetailsGoogleMap extends StatelessWidget {
  final Function(GoogleMapController) onMapCreated;

  const VisitDetailsGoogleMap({super.key, required this.onMapCreated});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitBloc, VisitState>(
      builder: (context, state) {
        return GoogleMap(
          mapType: MapType.terrain,
          initialCameraPosition: const CameraPosition(
              target: LatLng(23.791901, 90.426801), zoom: 14.4746),
          markers: state.markers.toSet(),
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            onMapCreated(controller);
          },
        );
      },
    );
  }
}
