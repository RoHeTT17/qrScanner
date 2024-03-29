import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';

class DireccionesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //Este calse no lleva Scaffold porque lo que
    //se esta cambiando es el body en el homepage


    /*

    Como el código es igual  al de mapa_page, se creo un Widget personalizado para optimizar.


    //Se cargan en base al tipo, el cual esta en el evento del  HomeScreen (porque este código es para el body)
    //Aquí si se necesita que se redibuje el widget al haber cambios, por eso no esta el párametro de listen: false
    final scanListProvider = Provider.of<ScanListProvider>(context);

    //támbien se puede hacer esot para no escribir todo el nombre
    final scan = scanListProvider.scans;

    return ListView.builder(
        itemCount: scan.length,
        itemBuilder: ( _ , int index) => ListTile(
          leading: Icon(Icons.home_outlined,color: Theme.of(context).primaryColor,),
          title: Text(scanListProvider.scans[index].valor),
          subtitle: Text('ID: '+scanListProvider.scans[index].id.toString()),
          trailing: Icon (Icons.keyboard_arrow_right),
          onTap: (){},
        )
    );

    */

    return ScanTiles(tipo: 'http');
  }
}