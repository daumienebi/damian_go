import 'dart:ui' as ui;
import 'package:damian_go/utils/countries_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

//https://blog.codemagic.io/creating-a-route-calculator-using-google-maps/
class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({Key? key}) : super(key: key);

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget>
    with AutomaticKeepAliveClientMixin {
  final location = Location().getLocation();
  final Map<String, LatLng> countryLocations = CountriesUtil.getAllCountries();
  late LocationData? userLocation;
  final Set<Marker> _markerList = {};
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(43.362343, -8.411540), zoom: 7.5);
  //Google Map stuffs
  CameraPosition _cameraPosition = _initialCameraPosition;
  bool _mapCreated = false;
  final bool _mapMoving = false;
  final bool _compasActivated = true;
  final bool _toolBarActivated = false;
  final CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  final MinMaxZoomPreference _minMaxZoomPreference =
      MinMaxZoomPreference.unbounded;
  final MapType _mapType = MapType.normal;
  final bool _rotationActivated = true;
  final bool _scrollActivated = true;
  final bool _tiltActivated = true;
  final bool _zoomGestureActivated = true;
  final bool _zoomControlsActivated = false;
  final bool _interiorViewActivated = true;
  final bool _trafficActivated = false;
  final bool _localizationActivated = true;
  final bool _localizationButtonActivated = true;
  late GoogleMapController _mapController;
  final bool _nightMode = true;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadIcon();
  }

  loadIcon() async {

    final customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        'assets/images/stick_250.png'
    );

    for (final countryName in countryLocations.keys) {
      final marker = Marker(
        markerId: MarkerId(countryName),
        position: countryLocations[countryName]!,
        infoWindow: InfoWindow(
          title: 'Country Test',
          snippet: 'Damian in $countryName',
        ),
        icon: customIcon,
      );
      _markerList.add(marker);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Generate a new place',
        //onPressed: _currentLocation,
        onPressed: () async{
          String countryName = await CountriesUtil.getCountryFromLocation(LatLng(userLocation!.latitude!, userLocation!.longitude!));
          if (countryName != null && countryLocations.containsKey(countryName)) {
            LatLng countryLocation = countryLocations[countryName]!;
          }
            showModalBottomSheet(
                barrierColor: Colors.black26,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  TextEditingController countryNameController = TextEditingController(
                    text: countryName
                  );
                  TextEditingController descController = TextEditingController();
                  TextEditingController latitudeController = TextEditingController(
                      text: _cameraPosition.target.latitude.toString());
                  TextEditingController longitudeController = TextEditingController(
                      text: _cameraPosition.target.longitude.toString());
                  return Container(
                    height: 350,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Add a new zone',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20
                            ),
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            child: ListView(
                              //scrollDirection: Axis.horizontal,
                              children: [
                                TextFormField(
                                    controller: countryNameController,
                                    decoration: InputDecorations
                                        .countryNameField()),
                                TextFormField(
                                  controller: descController,
                                  decoration: InputDecorations.descField(),
                                  maxLines: null,
                                ),
                                TextFormField(
                                  controller: latitudeController,
                                  decoration: InputDecorations.latField(),
                                  enabled: false,
                                ),
                                TextFormField(
                                    controller: longitudeController,
                                    decoration: InputDecorations.lngField()),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.blueGrey.shade900,
                                      shape: const StadiumBorder(),
                                      fixedSize: const Size(100, 50)
                                  ),
                                  child: const Text('Submit',
                                    style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  );
                });
        },
        backgroundColor: Colors.blueGrey.shade900,
        label: const Text('Add place',style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        icon: SizedBox(
          height: 80,
          width: 80,
          child: Image.asset('assets/images/piny.png'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: mapWidget(),
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: true,
        actions: const [
          Icon(Icons.new_releases),
          SizedBox(width: 10),
        ],
        elevation: 0,
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text('Damian Go'),

      ),
    );
  }

  Widget getMap(double latitude, double longitude) {
    final GoogleMap googleMap = GoogleMap(
      initialCameraPosition:
          CameraPosition(target: LatLng(latitude, longitude), zoom: 7.5),
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
      //myLocationButtonEnabled: _localizationButtonActivated,
      //myLocationEnabled: _localizationActivated,
      onMapCreated: onMapCreate,
      onCameraMove: _updateCameraPosition,
      trafficEnabled: _trafficActivated,
      markers: _markerList,
    );
    return googleMap;
  }

  void _currentLocation() async {
    final GoogleMapController controller = _mapController;
    LocationData? currentLocation;
    var location = Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    if (currentLocation != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 7.0,
        ),
      ));
    }
  }

  Widget mapWidget() {
    //the current location of the user has to be fetched
    return FutureBuilder(
        future: location,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final position = snapshot.data;
            userLocation = snapshot.data;
            _mapCreated = true;
            //_userLocation = position;
            return getMap(position.latitude, position.longitude);
          } else {
            return const Center(
                child: LinearProgressIndicator(semanticsLabel: 'Loading map'));
          }
        });
  }

  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      _cameraPosition = position;
    });
  }

  _mapNotCreated(context) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Sorry"),
              content: const Text("The map must be loaded first"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Valor de vuelta');
                    },
                    child: const Text('Accept')),
              ],
            ));
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

// Util
class BitmapDescriptorHelper {
  static Future<BitmapDescriptor> getBitmapDescriptorFromSvgAsset(
      BuildContext context, String svgAssetLink) async {
    final svgImage = await _getSvgImageFromAssets(context, svgAssetLink);
    final sizedSvgImage = await _getSizedSvgImage(svgImage);

    final pngSizedBytes =
    await sizedSvgImage.toByteData(format: ui.ImageByteFormat.png);
    final unit8List = pngSizedBytes?.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(unit8List!);
  }

  static Future<BitmapDescriptor> getBitmapDescriptorFromSvgString(
      String svgString) async {
    final svgImage = await _getSvgImageFromString(svgString);
    final sizedSvgImage = await _getSizedSvgImage(svgImage);

    final pngSizedBytes =
    await sizedSvgImage.toByteData(format: ui.ImageByteFormat.png);
    final unit8List = pngSizedBytes?.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(unit8List!);
  }

  static Future<ui.Image> _getSvgImageFromAssets(
      BuildContext context, String svgAssertLink) async {
    String svgString =
    await DefaultAssetBundle.of(context).loadString(svgAssertLink);
    DrawableRoot drawableRoot =
    svg.fromSvgString(svgString, 'null') as DrawableRoot;
    ui.Picture picture = drawableRoot.toPicture();
    ui.Image image = await picture.toImage(drawableRoot.viewport.width.toInt(),
        drawableRoot.viewport.height.toInt());
    return image;
  }

  static Future<ui.Image> _getSvgImageFromString(String svgString) async {
    DrawableRoot drawableRoot =
    svg.fromSvgString(svgString, 'null') as DrawableRoot;
    ui.Picture picture = drawableRoot.toPicture();
    ui.Image image = await picture.toImage(drawableRoot.viewport.width.toInt(),
        drawableRoot.viewport.height.toInt());
    return image;
  }

  static Future<ui.Image> _getSizedSvgImage(ui.Image svgImage) async {
    final size = 50 * ui.window.devicePixelRatio;
    final width = size;
    final height = width;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Rect svgRect = Rect.fromLTRB(
        0.0, 0.0, svgImage.width.toDouble(), svgImage.height.toDouble());
    final Rect sizedRect =
    Rect.fromLTRB(0.0, 0.0, width, height); // owr size here
    canvas.drawImageRect(svgImage, svgRect, sizedRect, Paint());
    return await pictureRecorder
        .endRecording()
        .toImage(width.toInt(), height.toInt());
  }
}

class InputDecorations{

  static InputDecoration countryNameField(){
    return const InputDecoration(
        labelText: "Country",
        icon: Icon(Icons.place),
        enabled: true
    );
  }

  static InputDecoration descField(){
    return const InputDecoration(
        labelText: "Description",
        icon: Icon(Icons.description),
        enabled: true
    );
  }

  static InputDecoration latField(){
    return const InputDecoration(
        labelText: "Latitude",
        icon: Icon(Icons.gps_fixed),
        enabled: false
    );
  }

  static InputDecoration lngField(){
    return const InputDecoration(
        labelText: "Longitude",
        icon: Icon(Icons.gps_fixed),
        enabled: false
    );
  }

  static InputDecoration searchPlaces(){
    BorderSide borderSide = const BorderSide(color: Colors.cyan);
    BorderRadius borderRadius = BorderRadius.circular(20);
    return  InputDecoration(
        hintText: 'Name of the place',
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: borderSide,

        ),
        prefixIcon: const Icon(Icons.search)

    );
  }
}