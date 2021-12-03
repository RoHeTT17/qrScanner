import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapasPage extends StatefulWidget {

  @override
  State<MapasPage> createState() => _MapasPageState();
}

class _MapasPageState extends State<MapasPage> {

  //Es un Future que contiene el googleMApController y nos sirve para que podamas trabajar con el
  //hasta que tengamos el googleMap. Se improta de dart:async
  //Se manipula el mapa con el controller
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    //Obtener los argumentos que se mandan. Se indica como se debe tratar al objeto
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicialCam = CameraPosition(
      target: scan.getLatLon(),
      //target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 17,
      tilt: 50, //inclinación del mapa
      //bearing: 37.5 // angulo del mapa
    );

    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
        markerId: MarkerId('EsUnico'),
        position: scan.getLatLon()
      )
    );

    //Este calse no lelva Scaffold porque lo que
    //se esta cambiando es el body en el homepage
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                                                                      new CameraPosition(
                                                                        target: scan.getLatLon(),
                                                                        zoom: 17,
                                                                        tilt: 50, )
                                                                     )
              );
            },
          )
        ],
      ),
      body: GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: markers,
              mapType: mapType,
              initialCameraPosition: puntoInicialCam,
              onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {

          setState(() {
            if( mapType == MapType.normal)
              mapType = MapType.satellite;
            else
              mapType = MapType.normal;
          });

        },
      ),
    );
  }
}