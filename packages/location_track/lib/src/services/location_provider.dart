import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';
import 'package:location_track/src/services/firebase_location_store_provider.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:path_provider/path_provider.dart';
import '../../location_track.dart';


Future openLocationBox() async {
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(LocationModelAdapter());
  await Hive.openBox<LocationModel>(location);
}

class LocationServiceProvider {
  late LocationService locationServiceProvider;
  HiveLocationProvider locationProvider = HiveLocationProvider();
  FirebaseLocationStoreProvider locationStoreProvider = FirebaseLocationStoreProvider();

  GeoLocatorService geoService = GeoLocatorService();
  LocationData userLocation = LocationData.fromMap({});
  geocoding.Placemark? placeMark;
  String place = '';
  late StreamSubscription locationSubscription;
  LatLng initialCameraPosition = const LatLng(23.256555, 90.157965);

  ///return future location
  Future<Position?> getUserPositionFuture() async {
    try{
      return await geoService.getCordFuture();
    }catch(e){
      rethrow;
    }
  }

  Future<String?> onLocationRefresh() async {
    Position? position = await getUserPositionFuture();
    try{
      if (position != null) {
        final places = await getAddressByPosition(position: position);
        placeMark = places?.first;
        place =
        '${placeMark?.street ?? ""}  ${placeMark?.subLocality ?? ""} ${placeMark?.locality ?? ""} ${placeMark?.postalCode ?? ""}';
      }
      return place;
    }catch(e){
      rethrow;
    }
  }

  ///return driver current location stream
  ///for this we use another package called {Location:any}
  ///to get location more better way
  void getCurrentLocationStream({required int uid, required MetaClubApiClient metaClubApiClient}) async {
    ///location permission check
    await askForLocationAlwaysPermission();

    locationServiceProvider = LocationService();

    ///listening data from location service
    locationSubscription = locationServiceProvider.locationStream.listen((event) async {
      ///initialize userLocation data
      userLocation = event;

      ///convert locationData into Position data
      final position = Position(
          latitude: event.latitude!,
          longitude: event.longitude!,
          speed: event.speed!,
          heading: event.heading!,
          altitude: event.altitude!,
          accuracy: event.accuracy!,
          timestamp: DateTime.now(),
          speedAccuracy: event.speedAccuracy!,
          altitudeAccuracy: 0,
          headingAccuracy: 0);

      ///when locationSubscription is enable only then
      ///location data can be processed to manipulate
      if (!locationSubscription.isPaused) {
        ///getting address from current position
        addLocationDataToLocal(position: position, uid: uid);

        ///store data to server from hive
        deleteDataAndSendToServer(metaClubApiClient: metaClubApiClient);

        ///Inactive all listener to listen location data for a while
        locationSubscription.pause();

        debugPrint('isPaused ${locationSubscription.isPaused}');
      }

      ///initial camera position
      initialCameraPosition = LatLng(event.latitude!, event.longitude!);

    });

    ///set timer to toggle location subscription
    Timer.periodic(const Duration(minutes: 2), (timer) async {
      if (locationSubscription.isPaused) {
        locationSubscription.resume();
      }
      debugPrint('isPaused ${locationSubscription.isPaused}');
    });
  }

  Future<List<geocoding.Placemark>?> getAddressByPosition(
      {required Position position}) async {
    return await geoService.getAddress(position);
  }

  ///return last stored location from hive database
  getLastLocationFromLocal() {
    return locationProvider.getUserLastPosition();
  }

  ///return first stored location from hive database
  getFirstLocationFromLocal() {
    return locationProvider.getUserFirstPosition();
  }

  ///store data to local
  addLocationDataToLocal(
      {String? currentDateData,
      required Position position,
      required int uid}) async {
    final places = await getAddressByPosition(position: position);

    placeMark = places?.first;

    place = '${placeMark?.street ?? ""}  ${placeMark?.subLocality ?? ""} ${placeMark?.locality ?? ""} ${placeMark?.postalCode ?? ""}';

    Timer.periodic(const Duration(minutes: 2), (timer) async {
      if (kDebugMode) {
        print('local from position ${position.toString()}');
      }

      if (!locationSubscription.isPaused) {
        double distance = 0.0;

        final locationModel = LocationModel(
            latitude: position.latitude,
            longitude: position.longitude,
            speed: position.speed,
            city: placeMark?.locality,
            country: placeMark?.country,
            countryCode: placeMark?.isoCountryCode,
            address:
            '${placeMark?.name} ${placeMark?.subLocality} ${placeMark?.thoroughfare} ${placeMark?.subThoroughfare}',
            heading: position.heading,
            distance: distance,
            datetime: DateTime.now().toString());

        ///add data to local database
        locationProvider.add(locationModel);

        FirebaseLocationStoreProvider.sendLocationToFirebase(uid, locationModel.toJson());
      }
    });
  }

  ///data will be delete after data store to server
  deleteDataAndSendToServer(
      {String? currentDateData,
      required MetaClubApiClient metaClubApiClient}) async {
    ///data will be stored to server after 4 minute
    Timer.periodic(const Duration(minutes: 4), (timer) async {
      if (locationProvider.toMapList().length > 2 &&  !locationSubscription.isPaused) {
        if (kDebugMode) {
          print('data that u have to sent server ${locationProvider.toMapList()}');
        }
        metaClubApiClient
            .storeLocationToServer(locations: locationProvider.toMapList(), date: DateTime.now().toString())
            .then((isStored) async {
          if (isStored) {
            await locationProvider.deleteAllLocation();
          }
        });
      }
    });
  }

  /// Tries to ask for "location always" permissions from the user.
  /// Returns `true` if successful, `false` otherwise.
  Future<bool> askForLocationAlwaysPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      return false;
    }
    return true;
  }
}
