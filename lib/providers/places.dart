import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return _items;
  }

  Place findById(String id){
    return _items.firstWhere((element) => element.id == id);
  }

  void addPlace(String title, File image, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        LatLng(pickedLocation.latitude, pickedLocation.longitude));
    final fullLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: fullLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'user_places',
      {
        //CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location.latitude,
        'loc_lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (e) => Place(
            //CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)
            id: e['id'],
            title: e['title'],
            image: File(e['image']),
            location: PlaceLocation(
              latitude: e['loc_lat'],
              longitude: e['loc_lng'],
              address: e['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
