import 'package:flutter/cupertino.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

class MapBottomSheet extends StatelessWidget {
  final Place place;

  const MapBottomSheet({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final address = place.displayName
        .substring(place.displayName.indexOf(",") + 1, place.displayName.length)
        .trim();
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 200,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              place.address?["shop"] ?? "Null",
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
    );
  }
}
