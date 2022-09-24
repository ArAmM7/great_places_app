import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/places.dart';
import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/places_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Places(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'Lato',
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.indigo,
              onPrimary: Colors.white,
              secondary: Colors.amber,
              onSecondary: Colors.black,
              background: Colors.white70,
              onBackground: Colors.grey,
              error: Colors.red,
              onError: Colors.white,
              surface: Colors.white70,
              onSurface: Colors.black)),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
          PlacesDetailScreen.routeName:(context) => const PlacesDetailScreen(),
        },
      ),
    );
  }
}
