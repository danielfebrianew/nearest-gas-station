import 'package:flutter/cupertino.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

class MapBottomSheet extends StatelessWidget {
  final Place place;

  const MapBottomSheet({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    const _secondaryColor = Color(0xffB3D1CB);

    final address = place.displayName
        .substring(place.displayName.indexOf(",") + 1, place.displayName.length)
        .trim();

    final placesName =
        place.displayName.substring(0, place.displayName.indexOf(",")).trim();

    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: _secondaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 100,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                placesName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                address,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
