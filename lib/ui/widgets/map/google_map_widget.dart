import 'dart:async';

import 'package:damian_go/ui/screens/drawer_screen.dart';
import 'package:damian_go/ui/screens/star_level_screen.dart';
import 'package:damian_go/utils/constants.dart';
import 'package:damian_go/utils/countries_util.dart';
import 'package:damian_go/utils/star_level_util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:location/location.dart';

//https://blog.codemagic.io/creating-a-route-calculator-using-google-maps/
class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({Key? key}) : super(key: key);

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget>
    with AutomaticKeepAliveClientMixin {

  //
  Color _startColor = Colors.lightBlue.shade100;
  Color _endColor = Colors.redAccent.shade100;
  bool _isForward = true;
  late Timer timer;
  //

  late var location;
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
    setUserLocation();
    loadDamianZones();
    initAnimationStuff();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  initAnimationStuff(){
    // initialize the start and end colors
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        if (_isForward) {
          _startColor = _endColor;
          _endColor = Colors.blue;
        } else {
          _startColor = _endColor;
          _endColor = Colors.red;
        }
        _isForward = !_isForward;
      });
    });
  }

  setUserLocation() async{
    location = Location().getLocation();
  }

  loadDamianZones() async {
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
          snippet: 'Damian zone in $countryName',
        ),
        icon: customIcon,
      );
      _markerList.add(marker);
    }
  }

  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Container(
            color: Colors.blueGrey.shade900,
            height: 60,
            child: ListView(
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.horizontal,
              children: [
                optionButton(text:'Top users ⭐️',onPressed: (){},backgroundColor: Colors.white),
                optionButton(
                  text:'Search users 🔎',
                  onPressed: (){},
                  backgroundColor: Colors.white,
                ),
                optionButton(
                    text:'Location 📍',
                    onPressed: ()=> currentLocation(),
                    backgroundColor: Colors.white,
                ),
                optionButton(
                  text:'✨ New zones ✨',
                  onPressed: ()=> currentLocation(),
                  backgroundColor: Colors.white,
                ),
                optionButton(
                    text:'Base (Spain)',
                    onPressed: (){
                      moveToLocation(countryLocations['Spain']!);
                    },
                    backgroundColor: Colors.white),
                optionButton(text:'Globe view  🌍',onPressed: (){},backgroundColor: Colors.white),
              ],
            ),
          ),
          Expanded(child: mapWidget()),
        ],
      ),
      appBar: AppBar(
        // use the leading icon for the drawer
        leading: InkWell(
            onTap: () =>
                Navigator.of(context).push(createRouteWithSlideAnimation()),
          child: Icon(Icons.menu),
        ),
        //toolbarHeight: 50,
        centerTitle: true,
        actions: [
          //Icon(Icons.mode_night_outlined),
          popupMenuButton(),
        ],
        elevation: 0,
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text('Damian Go'),

      ),
    );
  }

  Widget floatingActionButton(){
    return InkWell(
      onTap: () async{
        String countryName = await CountriesUtil.getCountryFromLocation(
          //use Spain as the default value if the userLocation is null
            LatLng(userLocation!.latitude ?? 40.463667, userLocation!.longitude ?? -3.74922)
        );
        //if (countryLocations.containsKey(countryName)) {
        //  LatLng countryLocation = countryLocations[countryName]!;
        //}
        showModalBottomSheet(
            barrierColor: Colors.black26,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              TextEditingController countryNameController = TextEditingController(
                  text: countryName
              );
              return Container(
                height: 380,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 7, right: 7),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/damian_small.png'),
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
                                decoration: InputDecoration(
                                    labelText: "Country",
                                    icon: Icon(Icons.place),
                                    enabled: false
                                )
                            ),
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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1500),
        curve: Curves.easeInOut,
        //width: 200,
        margin: EdgeInsets.all(5),
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_startColor, _endColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
              width: 90,
              child: Image.asset('assets/images/piny.png'),
            ),
            /*
            Text(
                'Add zone',
                style: TextStyle(fontSize: 15,color: Colors.white)
            ),
             */
          ],
        ),
      ),
    );
  }

  /// The app bar actions to view a simple menu
  PopupMenuButton popupMenuButton(){
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'menu_item_1',
          child: Text('Privacy Policy'),
        ),
        PopupMenuItem<String>(
          value: 'menu_item_2',
          child: Text('Terms & conditions'),
        ),
        PopupMenuItem<String>(
          value: 'menu_item_3',
          child: Text('Help'),
        ),
      ],
      onSelected: (String value) {
        // Handle menu item selection
        switch (value) {
          case 'menu_item_1':
            Navigator.of(context).push(
                _createRoute(page: StarLevelScreen()));
            break;
          case 'menu_item_2':
            Navigator.of(context).push(
                _createRoute(page: StarLevelScreen()));
            break;
          case 'menu_item_3':
            Navigator.of(context).push(
                _createRoute(page: StarLevelScreen()));
            break;
        }
      },
    );
  }

  Route _createRoute({required page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  Widget optionButton({required String text,Function()? onPressed,Color? backgroundColor}){
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))
            ),
            child: Text(text,style: TextStyle(color: Colors.black),),

          ),
        ],
      )
    );
  }

  Widget getMap(double latitude, double longitude) {
    final GoogleMap googleMap = GoogleMap(
      initialCameraPosition:
          CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 1,
            tilt: 20,
          ),
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

  /// method to navigate to the users current location
  void currentLocation() async {
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

  void moveToLocation(LatLng latLng) async {
    final GoogleMapController controller = _mapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(latLng.latitude, latLng.longitude),
        zoom: 7.0,
      ),
    ));
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulseRise,
                      colors: Constants.loadingIndicatorColors,
                    ),
                  ),
                  Text('Loading map...')
                ],
              )
            );
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

  Route createRouteWithSlideAnimation() {
    return PageRouteBuilder(
      settings: RouteSettings(name: 'drawerScreen',),
      pageBuilder: (context, animation, secondaryAnimation) => const DrawerScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.5, 1);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  //https://stackoverflow.com/questions/56632225/google-maps-dequeuebuffer-bufferqueue-has-been-abandoned
  bool get wantKeepAlive => true;
}