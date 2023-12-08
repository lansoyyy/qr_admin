import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../widgets/drivers_dialog.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Drivers')
            .where('isActive', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('Error'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
            );
          }

          final data = snapshot.requireData;

          return InteractiveViewer(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(16.9754, 121.8107),
                zoom: 12.0,
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                MarkerLayerOptions(
                  markers: [
                    for (int i = 0; i < data.size; i++)
                      Marker(
                        height: 50,
                        width: 50,
                        point:
                            LatLng(data.docs[i]['lat'], data.docs[i]['lang']),
                        builder: (ctx) => GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => DriverInfoDialog(
                                profilePicture: data.docs[i]['profile_picture'],
                                name: data.docs[i]['name'],
                                contactNumber: data.docs[i]['contact_number'],
                                vehicleModel: data.docs[i]['vehicle_model'],
                                vehicleColor: data.docs[i]['vehicle_color'],
                                vehiclePlateNumber: data.docs[i]
                                    ['plate_number'],
                              ),
                            );
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/driver.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
              children: const [],
            ),
          );
        });
  }
}
