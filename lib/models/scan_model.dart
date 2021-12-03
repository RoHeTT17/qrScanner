// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

//Recibe el json string y crea una instanci del modelo
ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {

    int? id;
    String? tipo;
    String valor;

    ScanModel({ this.id, this.tipo, required this.valor,}){

      if(this.valor.contains('http'))
          this.tipo= 'http';
      else  
          this.tipo = 'geo';    
    }

    // recibe un map al que llama json y crea una instancia de ScanModel
    // en teoria 'lee' un json
    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );

    //toma la instancia de una clase y la pasa a un Map
    //Sirve para utilizarlo con SQFLite
    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
    };

    LatLng getLatLon(){

        //1. Quitar la palabra "geo:", depués obtener un arreglo con las coordenadas
        final latLong = this.valor.substring(4).split(",");
        //2. Parsear el arreglo , de acuerdo a su posición
        final lat = double.parse(latLong[0]);
        final lon = double.parse(latLong[1]);

        return LatLng(lat, lon);
    }
}
