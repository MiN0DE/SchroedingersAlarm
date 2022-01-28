import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMap extends StatefulWidget {
  final double longitude;
  final double latitude;

  const SimpleMap(this.longitude, this.latitude);

  @override
  _SimpleMapState createState() => _SimpleMapState();
}


class _SimpleMapState extends State<SimpleMap> {
  late double latitudeNumber= widget.latitude;
  late double longtiudeNumber = widget.longitude;
  late LatLng _kMapCenter = LatLng(latitudeNumber, longtiudeNumber);


   late CameraPosition _kInitialPosition =
  CameraPosition(target: _kMapCenter, zoom: 30.0, tilt: 0, bearing: 0);



  late GoogleMapController _controller;

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _controller.setMapStyle(value);
  }

  void onCameraMove(CameraPosition cameraPosition) {
    debugPrint('${cameraPosition}');
  }

  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: MarkerId("marker_1"),
          position: _kMapCenter,
          infoWindow: InfoWindow(title: 'Marker 1'),
          rotation: 90),
    };
  }

  Set<Circle> _createCircle() {
    return {
      Circle(
        circleId: CircleId('1'),
        consumeTapEvents: true,
        strokeColor: Colors.teal,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeWidth: 2,
        center: _kMapCenter,
        radius: 5000,
      ),
    };
  }

  Set<Polygon> _createPolygon() {
    return {
      Polygon(
          polygonId: PolygonId('2'),
          consumeTapEvents: true,
          strokeColor: Colors.black,
          strokeWidth: 2,
          fillColor: Colors.teal,
          )
    };
  }

  Set<Polyline> _createPolyline() {
    return {
      Polyline(
        polylineId: PolylineId('1'),
        consumeTapEvents: true,
        color: Colors.black,
        width: 5,
      ),
    };
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Builder(builder: (BuildContext context) {
          return GoogleMap(
            initialCameraPosition: _kInitialPosition,
            onMapCreated: onMapCreated,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            markers: _createMarker(),
            mapToolbarEnabled: false,
            buildingsEnabled: true,
            onTap: (latLong) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                    'Tapped location LatLong is (${latLong.latitude},${latLong.longitude})'),
              ));
            },
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: true,
            liteModeEnabled: false,
            //circles: _createCircle(),
            //polygons: _createPolygon(),
            //polylines: _createPolyline(),
            trafficEnabled: false,
            onCameraMove: onCameraMove,
          );
        }));
  }
}