# great_places_app

An app that lets you save places locally, taking pictures of the place and adding location using the
device location or by selecting on Google Maps. My fifth app using flutter, interacting with native
device features, like GPS, Camera, device storage, and local SQLite.

The [Provider package](https://pub.dev/packages/provider) is used which for state management, which
is enough for this kind and size of app. The [http package](https://pub.dev/packages/http) is used
to communicate with Google Maps
Platform's [Geocoding API](https://developers.google.com/maps/documentation/geocoding)
and [Maps Static API](https://developers.google.com/maps/documentation/maps-static),
[sqflite](https://pub.dev/packages/sqflite) is used for local
DB, [image_picker](https://pub.dev/packages/image_picker) is used to interact with the
camera, [path_provider](https://pub.dev/packages/path_provider)
and [path](https://pub.dev/packages/path) are used for local storage path
manipulation, [location ](https://pub.dev/packages/location) is used for getting GPS data,
and [google_maps_flutter](https://pub.dev/packages/google_maps_flutter) is used for displaying maps
and selecting location. 