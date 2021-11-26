import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scans_list_provider.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';


class MapaScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    /*

      Como el código es igual  al de mapa_page, se creo un Widget personalizado para optimizar.



    //Se cargan en base al tipo, el cual esta en el evento del  HomeScreen

    //Aquí si se necesita que se redibuje el widget al haber cambios, por eso no esta el párametro de listen: false
    final scanListProvider = Provider.of<ScanListProvider>(context);

    //támbien se puede hacer esot para no escribir todo el nombre
    final scan = scanListProvider.scans;

    return ListView.builder(
          itemCount: scan.length,
          itemBuilder: ( _ , int index) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction){
              Provider.of<ScanListProvider>(context,listen: false)
                  .borrarScanPorID(scanListProvider.scans[index].id!);
            } ,
            child: ListTile(
              leading: Icon(Icons.map,color: Theme.of(context).primaryColor,),
              title: Text(scanListProvider.scans[index].valor),
              subtitle: Text('ID: '+scanListProvider.scans[index].id.toString()),
              trailing: Icon (Icons.keyboard_arrow_right),
              onTap: (){},
            ),
          )
      );
    */

    return ScanTiles(tipo: 'geo');

  }
}