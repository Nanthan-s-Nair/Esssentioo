import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController controller = MapController(
    initPosition: GeoPoint(latitude: 13.0827, longitude: 80.2707), // Chennai, India
    areaLimit: const BoundingBox(
      east: 88.1748047,
      north: 37.0902,
      south: 6.4627,
      west: 68.1766459,
    ),
  );

  GeoPoint? _deliveryPoint;

  Future<void> _setDeliveryPoint(GeoPoint point) async {
    setState(() {
      _deliveryPoint = point;
    });
    // Adding a marker manually
    await controller.addMarker(
      point,
      markerIcon: const MarkerIcon(
        icon: Icon(
          Icons.location_on,
          color: Colors.blue,
          size: 48,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Delivery point set to: ${point.latitude}, ${point.longitude}')),
    );
  }

  @override
  void initState() {
    super.initState();
    controller.listenerMapSingleTapping.addListener(() async {
      final tappedPoint = controller.listenerMapSingleTapping.value;
      if (tappedPoint != null) {
        await _setDeliveryPoint(tappedPoint);
      }
    });
  }

  @override
  void dispose() {
    controller.listenerMapSingleTapping.removeListener(() {});
    controller.dispose();
    super.dispose();
  }

  // Converts GeoPoint to address string (replace with actual geocoding service)
  Future<String> _convertCoordinatesToAddress(GeoPoint point) async {
    // Replace this with a geocoding API or plugin method
    return "Chennai, India";  // Static string for example purposes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Delivery Location'),
      ),
      body: OSMFlutter(
        controller: controller,
        osmOption: OSMOption(
          userTrackingOption: const UserTrackingOption(
            enableTracking: true,
            unFollowUser: false,
          ),
          zoomOption: const ZoomOption(
            initZoom: 12,
            minZoomLevel: 3,
            maxZoomLevel: 19,
            stepZoom: 1.0,
          ),
          userLocationMarker: UserLocationMaker(
            personMarker: const MarkerIcon(
              icon: Icon(
                Icons.location_history_rounded,
                color: Colors.red,
                size: 48,
              ),
            ),
            directionArrowMarker: const MarkerIcon(
              icon: Icon(
                Icons.double_arrow,
                size: 48,
              ),
            ),
          ),
          roadConfiguration: const RoadOption(
            roadColor: Colors.yellowAccent,
          ),
        ),
      ),
      floatingActionButton: _deliveryPoint != null
          ? FloatingActionButton.extended(
              onPressed: () async {
                // Convert selected point to an address and pass back to HomePage
                String address = await _convertCoordinatesToAddress(_deliveryPoint!);
                // ignore: use_build_context_synchronously
                Navigator.pop(context, address);
              },
              label: const Text("Confirm Delivery Point"),
              icon: const Icon(Icons.location_on),
            )
          : null,
    );
  }
}
