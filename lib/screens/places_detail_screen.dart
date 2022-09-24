import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import './map_screen.dart';

class PlacesDetailScreen extends StatelessWidget {
  const PlacesDetailScreen({Key? key}) : super(key: key);

  static String routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final String? id = ModalRoute.of(context)?.settings.arguments.toString();
    final selectedPlace = Provider.of<Places>(context, listen: false).findById(id!);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(selectedPlace.location.address, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => MapScreen(initialLocation: selectedPlace.location),
                    ),
                  ),
              child: const Text('View on map'))
        ],
      ),
    );
  }
}
