import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final bool isSelecting;
  final PlaceLocation initialLocation;

  const MapScreen({
    Key? key,
    this.isSelecting = false,
    this.initialLocation = const PlaceLocation(latitude: 40.187252, longitude: 44.515225),
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select New Place Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed:
                  _pickedLocation == null ? null : () => Navigator.of(context).pop(_pickedLocation),
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        //liteModeEnabled: widget.isSelecting ? false : true,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: widget.isSelecting && _pickedLocation == null
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _pickedLocation ??
                      LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude),
                ),
              },
      ),
    );
  }
}
