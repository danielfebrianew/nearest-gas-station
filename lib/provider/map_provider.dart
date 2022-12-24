import 'package:find_nearest_gas_station/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/map_bottom_sheet.dart';

class MapItem {
  final String marketName;
  final String cityName;
  LatLng? cityCoordinate;
  List<Place>? place;

  MapItem({
    required this.marketName,
    required this.cityName,
    this.place,
    this.cityCoordinate,
  });
}

class MapProvider with ChangeNotifier {
  MapItem _mapItem = MapItem(marketName: '', cityName: '', place: null);
  final List<Marker> _markers = [];

  MapItem get mapItem => _mapItem;

  set setMapItem(MapItem mapItem) => _mapItem = mapItem;

  List<Marker> get markers => [..._markers];

  List<Place> get mapPlaces {
    return [..._mapItem.place!];
  }

  void addLocation(String market, String city) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(marketKey, market);
    prefs.setString(cityKey, city);
  }

  Future<void> searchLocation() async {
    final prefs = await SharedPreferences.getInstance();
    String market = prefs.getString(marketKey) ?? "";
    String city = prefs.getString(cityKey) ?? "";
    if (kDebugMode) {
      print('market : $market');
      print('city: $city');
    }
    final places = await Nominatim.searchByName(
      street: market,
      city: city,
      limit: 30,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    print('places : $places');
    if (places.isNotEmpty) {
      setMapItem = MapItem(
        marketName: market,
        cityName: city,
        place: places,
        cityCoordinate: LatLng(places.first.lat, places.first.lon),
      );
    } else {
      setMapItem = MapItem(
        marketName: '',
        cityName: '',
        place: await Nominatim.searchByName(
          street: '',
          city: '',
          limit: 30,
          addressDetails: true,
          extraTags: true,
          nameDetails: true,
        ),
        cityCoordinate: LatLng(-7.797068, 110.370529),
      );
    }
    notifyListeners();
  }

  void addMarker(BuildContext context, MapController mapController) {
    if (_mapItem.place != null) {
      _markers.addAll(
        mapPlaces.map(
          (e) => Marker(
            width: 80,
            height: 80,
            point: LatLng(e.lat, e.lon),
            builder: (ctx) => Container(
              key: Key(e.placeId.toString()),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                onPressed: () => {
                  mapController.move(LatLng(e.lat, e.lon), 12),
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (ctx) => MapBottomSheet(place: e),
                  ),
                },
              ),
            ),
          ),
        ),
      );
    }
  }
}
