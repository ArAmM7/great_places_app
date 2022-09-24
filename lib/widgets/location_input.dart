import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput(this.onSelectPlace, {Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl = '';

  // var cords = LatLng(0, 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).colorScheme.onBackground),
          ),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          //child: cords == LatLng(0, 0)
          child: _previewImageUrl.isEmpty
              ? const Text('No location chosen')
              : Image.network(
                  _previewImageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          // : FlutterMap(
          //     mapController: null,
          //     options: MapOptions(
          //       center: cords,
          //       zoom: 14,
          //       swPanBoundary: cords,
          //       nePanBoundary: cords,
          //     ),
          //     children: [
          //       TileLayer(
          //         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          //       ),
          //       MarkerLayer(markers: [
          //         Marker(
          //           point: cords,
          //           builder: (context) => const Icon(Icons.location_on),
          //         )
          //       ]),
          //     ],
          //   ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select On Map'),
            ),
          ],
        ),
      ],
    );
  }

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl.toString();
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(LatLng(locData.latitude!, locData.longitude!));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _selectOnMap() async {
    //final locData = await Location().getLocation();
    if (!mounted) return;
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const MapScreen(
          isSelecting: true,
          // initialLocation:
          //     PlaceLocation(latitude: locData.latitude!, longitude: locData.longitude!),
        ),
      ),
    );
    _showPreview(selectedLocation!.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation);
  }
}
