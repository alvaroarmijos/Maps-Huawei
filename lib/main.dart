/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:demo_mapa_1/MyHumoePageAnalitics.dart';
import 'package:demo_mapa_1/screens/auth_screen.dart';
import 'package:demo_mapa_1/screens/fusedlocation_screen.dart';
import 'package:demo_mapa_1/screens/home_screen.dart';
import 'package:flutter/material.dart';

//push
import 'package:flutter/services.dart';
import 'package:huawei_push/push.dart';
import 'package:huawei_push/constants/channel.dart' as Channel;

import 'package:huawei_map/components/components.dart';

import 'components/circleDemo.dart';
import 'components/groundOverlayDemo.dart';
import 'components/markerDemo.dart';
import 'components/polygonDemo.dart';
import 'components/polylineDemo.dart';
import 'components/tileOverlayDemo.dart';
import 'customWidgets/customCard.dart';
import 'huaweiMapDemo.dart';
import 'screens/activity_conversion_screen.dart';
import 'screens/activity_identification_screen.dart';
import 'screens/activity_screen.dart';
import 'screens/add_geofence_screen.dart';
import 'screens/geofence_screen.dart';
import 'screens/location_enhance_screen.dart';
import 'screens/location_updates_cb_screen.dart';
import 'screens/location_updates_ex_cb_screen.dart';
import 'screens/location_updates_screen.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false, title: "Demo map 1", home: HomePage()
    //home: AuthScreen(),
    //home: MyHomePage(),
    ));

//location kit
// void main() => runApp(LocationKitDemoApp());

// class LocationKitDemoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//       routes: {
//         HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
//         FusedLocationScreen.ROUTE_NAME: (context) => FusedLocationScreen(),
//         ActivityScreen.ROUTE_NAME: (context) => ActivityScreen(),
//         GeofenceScreen.ROUTE_NAME: (context) => GeofenceScreen(),
//         AddGeofenceScreen.ROUTE_NAME: (context) => AddGeofenceScreen(),
//         ActivityIdentificationScreen.ROUTE_NAME: (context) =>
//             ActivityIdentificationScreen(),
//         ActivityConversionScreen.ROUTE_NAME: (context) =>
//             ActivityConversionScreen(),
//         LocationUpdatesScreen.ROUTE_NAME: (context) => LocationUpdatesScreen(),
//         LocationUpdatesCbScreen.ROUTE_NAME: (context) =>
//             LocationUpdatesCbScreen(),
//         LocationUpdatesExCbScreen.ROUTE_NAME: (context) =>
//             LocationUpdatesExCbScreen(),
//         LocationEnhanceScreen.ROUTE_NAME: (context) => LocationEnhanceScreen(),
//       },
//     );
//   }
// }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double top = 0.0;
  double distance = 0.0;
  bool hmsLoggerStatus = true;

  String _token = '';

  static const EventChannel TokenEventChannel =
      EventChannel(Channel.TOKEN_CHANNEL);

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getToken();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    TokenEventChannel.receiveBroadcastStream()
        .listen(_onTokenEvent, onError: _onTokenError);
  }

  void _onTokenEvent(Object event) {
    // This function gets called when we receive the token successfully
    setState(() {
      _token = event;
    });
    print('Push Token: ' + _token);
    Push.showToast(event);
  }

  void _onTokenError(Object error) {
    setState(() {
      _token = error;
    });
    Push.showToast(error);
  }

  void getToken() async {
    await Push.getToken("");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: false,
          expandedHeight: 220.0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/banner2.png",
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              ),
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                top = constraints.biggest.height;
                return FlexibleSpaceBar(
                  centerTitle: true,
                  background: AnimatedOpacity(
                    opacity: top >= 220 ? 1.0 : 0.2,
                    duration: Duration(milliseconds: 300),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          "Huawei Map Kit, provides standard maps as well as UI elements such as markers, shapes, and layers for you to customize maps that better meet service scenarios.",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  title: Text('Huawei Map Flutter Demo',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                  collapseMode: CollapseMode.pin,
                );
              })),
        ),
        new SliverList(
            delegate: new SliverChildListDelegate([
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              CustomCard(
                imagePath: "assets/map.jpg",
                text: "Map Options",
                subText:
                    "Map Listeners, Traffic, Map Type, Camera Animation and more",
                textColor: Colors.white,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HuaweiMapDemo()));
                },
              ),
              CustomCard(
                imagePath: "assets/marker.jpg",
                text: "Markers",
                subText:
                    "Listeners, Animations, Marker Clustering, Info Windows and more",
                textColor: Colors.white,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MarkerDemo()));
                },
              ),
              CustomCard(
                imagePath: "assets/circle.jpg",
                text: "Circles",
                subText: "Listeners, Color Settings, Stroke Settings and more",
                textColor: Colors.white,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CircleDemo()));
                },
              ),
              CustomCard(
                imagePath: "assets/polyline.jpg",
                text: "Polylines",
                subText: "Listeners, Patterns, Caps and more",
                textColor: Colors.white,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PolylineDemo()));
                },
              ),
              CustomCard(
                imagePath: "assets/polygon.jpg",
                text: "Polygons",
                subText: "Listeners, zIndex and more",
                textColor: Colors.white,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PolygonDemo()));
                },
              ),
              CustomCard(
                imagePath: "assets/groundOverlay.jpg",
                text: "Ground Overlays",
                subText: "Listeners, Size, Transparency and more",
                textColor: Colors.white,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroundOverlayDemo()));
                },
              ),
              CustomCard(
                imagePath: "assets/tileOverlay.jpg",
                text: "Tile Overlays",
                subText: "Tiles, URL Tiles, Tile Caches and more",
                textColor: Colors.white,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TileOverlayDemo()));
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Distance Calculator",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Calculate distance between to coordinate points."),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () async {
                    double result = await HuaweiMapUtils.distanceCalculator(
                        start: LatLng(41.048641, 28.977033),
                        end: LatLng(41.063984, 29.033135));

                    setState(() {
                      distance = result;
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  color: Color.fromRGBO(18, 26, 55, 1),
                  textColor: Colors.white,
                  splashColor: Colors.redAccent,
                  padding: EdgeInsets.all(12.0),
                  child: Text("Calculate"),
                ),
              ),
              distance == 0.0
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(distance.toString()),
                    ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
                child: Text(
                  "This method enables/disables the HMSLogger capability which is used for sending usage analytics of Map SDK's methods to improve the service quality.",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    if (hmsLoggerStatus) {
                      HuaweiMapUtils.disableLogger();
                      hmsLoggerStatus = false;
                    } else {
                      HuaweiMapUtils.enableLogger();
                      hmsLoggerStatus = true;
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  color: Color.fromRGBO(18, 26, 55, 1),
                  textColor: Colors.white,
                  splashColor: Colors.redAccent,
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Enable/Disable Logger",
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          )
        ])),
      ],
    ));
  }
}
