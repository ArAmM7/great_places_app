import 'package:flutter/material.dart';
import 'package:great_places_app/screens/places_detail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YourPlaces'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Places>(
                builder: (context, places, child) => places.items.isEmpty
                    ? child!
                    : ListView.builder(
                        itemCount: places.items.length,
                        itemBuilder: (BuildContext context, int index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(places.items[index].image),
                          ),
                          title: Text(places.items[index].title),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          subtitle: Text(places.items[index].location.address),
                          onTap: () => Navigator.of(context).pushNamed(PlacesDetailScreen.routeName,
                              arguments: places.items[index].id),
                        ),
                      ),
                child: const Center(
                  child: Text('Got no places yet, start adding some!'),
                ),
              ),
      ),
    );
  }
}
