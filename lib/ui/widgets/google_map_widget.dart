import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({Key? key}) : super(key: key);

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget>
    with AutomaticKeepAliveClientMixin {
  final location = Location().getLocation();

  static const _initialCameraPosition =
  CameraPosition(target: LatLng(43.362343, -8.411540), zoom: 7.5);
  String placeName = "";
  String desc = "";
  //Google Map stuffs
  CameraPosition _cameraPosition = _initialCameraPosition;
  bool _mapCreated = false;
  final bool _mapMoving = false;
  final bool _compasActivated = true;
  final bool _toolBarActivated = false;
  final CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  final MinMaxZoomPreference _minMaxZoomPreference =
      MinMaxZoomPreference.unbounded;
  final MapType _mapType = MapType.hybrid;
  final bool _rotationActivated = true;
  final bool _scrollActivated = true;
  final bool _tiltActivated = true;
  final bool _zoomGestureActivated = true;
  final bool _zoomControlsActivated = false;
  final bool _interiorViewActivated = true;
  final bool _trafficActivated = false;
  final bool _localizationActivated = true;
  final bool _localizationButtonActivated = true;
  late GoogleMapController
  _mapController; //must be instanciated or defined as late
  final bool _nightMode = true;

  @override
  Widget build(BuildContext context) {
    return mapWidget();
  }

  Widget _getMap(double latitude, double longitude) {
    final GoogleMap googleMap = GoogleMap(
        initialCameraPosition:
        CameraPosition(target: LatLng(latitude, longitude), zoom: 7),
        compassEnabled: _compasActivated,
        mapToolbarEnabled: _toolBarActivated,
        cameraTargetBounds: _cameraTargetBounds,
        minMaxZoomPreference: _minMaxZoomPreference,
        mapType: _mapType,
        rotateGesturesEnabled: _rotationActivated,
        scrollGesturesEnabled: _scrollActivated,
        tiltGesturesEnabled: _tiltActivated,
        zoomControlsEnabled: _zoomControlsActivated,
        zoomGesturesEnabled: _zoomGestureActivated,
        myLocationButtonEnabled: _localizationActivated,
        myLocationEnabled: _localizationButtonActivated,
        onMapCreated: onMapCreate,
        onCameraMove: _updateCameraPosition,
        trafficEnabled: _trafficActivated,
    );
    return googleMap;
  }

  Widget mapWidget() {
    //the current location of the user has to be fetched
    return FutureBuilder(
        future: location,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final position = snapshot.data;
            _mapCreated = true;
            //_userLocation = position;
            return SafeArea(

                child: _getMap(position.latitude, position.longitude));

          } else {
            return const Center(child: LinearProgressIndicator(semanticsLabel: 'Loading map'));
          }
        });
  }

  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      _cameraPosition = position;
    });
  }

  _mapNotCreated (context){
    return showDialog(
        context: context,
        builder: (_) =>AlertDialog(
          title: const Text("Sorry"),
          content: const Text("The map must be loaded first"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(onPressed: (){
              Navigator.pop(context,'Valor de vuelta');
            },
                child: const Text('Accept')),
          ],
        )
    );
  }

  _checkResult(int result) {
    result > 0
        ? ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('New Location saved')))
        : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
        Text('The location was not saved, introduce a valid name')));
    Navigator.pop(context);
  }

  void onMapCreate(GoogleMapController mapController) {
    setState(() {
      _mapController = mapController;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  //https://stackoverflow.com/questions/56632225/google-maps-dequeuebuffer-bufferqueue-has-been-abandoned
  bool get wantKeepAlive => true;
}