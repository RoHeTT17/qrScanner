import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scan) async {

  final url = scan.valor;


  if( scan.tipo == 'http'){

    if (!await launch(url)) throw 'No se puedo abrir $url';

  }else{
    Navigator.pushNamed(context,'mapa',arguments: scan);
  }


}