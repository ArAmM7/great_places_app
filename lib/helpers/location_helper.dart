import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../.secrets/secrets.dart'; // file where sensitive information is stored

class LocationHelper {
  //https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap
  // &markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318
  // &markers=color:red%7Clabel:C%7C40.718217,-73.998284
  // &key=YOUR_API_KEY&signature=YOUR_SIGNATURE
  static Uri generateLocationPreviewImage({required double latitude, required double longitude}) {
    return Uri.https(
      'maps.googleapis.com',
      '/maps/api/staticmap',
      {
        'center': '$latitude,$longitude',
        'zoom': '16',
        'size': '600x300',
        'maptype': 'roadmap',
        'markers': 'color:red|$latitude,$longitude',
        'key': API_KEY,
      },
    );
  }

  static Future<String> getPlaceAddress(LatLng cords) async {
    //https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=YOUR_API_KEY
    final url = Uri.https(
      'maps.googleapis.com',
      '/maps/api/geocode/json',
      {
        'latlng': '${cords.latitude},${cords.longitude}',
        'zoom': '16',
        'key': API_KEY,
      },
    );
    final response = await http.post(url);

    print(jsonDecode(response.body)['results'][0]['formatted_address']);
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}



