import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/models/scan_model.dart';

import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/pages/mapa_historial_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scans_list_provider.dart';

import 'package:qr_reader/providers/ui_provider.dart';

import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_buttom.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){

              /*final scanProvider = Provider.of<ScanListProvider>(context,listen: false);
              scanProvider.borrarTodos();*/

              //Esta es otra forma de hacerlo
              Provider.of<ScanListProvider>(context,listen: false).borrarTodos();

            },
            )
        ],
      ),
      body: _HomePageBody(),
     bottomNavigationBar: CustomNavigatorBar(),
     floatingActionButton: ScanButtom(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //obtener el selecte menu opt (gracias al provider)

    final uiProvider = Provider.of<UiProvider>(context);

    // Cambiar para mostrar la página respectiva
    final currentIndex = uiProvider.selectedMenuOpt;


    //temporal para probar que esta funcionan la creación de la BD
    //final tempScan = new ScanModel(valor: 'http://google.com');
    //DBProvider.db.getScanByID(4).then((scan) => print(scan.valor));

    //prueba de borrar todos los scans
    //DBProvider.db.deleteAllScan().then(print);

    //Usar el ScanListProvider
    //el lsiten en false porque no queremos que se redibjue a este nivel
    final scanListProvider = Provider.of<ScanListProvider>(context,listen: false);

    switch (currentIndex) {
      case 0:

        //final tempScan = new ScanModel(valor: '15.33,15.66');
        //DBProvider.db.nuevoScan(tempScan);

          scanListProvider.cargarScanByType('geo');
          return HistorialMapaScreen();
        break;
      case 1:
          //final tempScan = new ScanModel(valor: 'http://google.com');
          //DBProvider.db.nuevoScan(tempScan);

          scanListProvider.cargarScanByType('http');
          return DireccionesScreen();
        break;        
      default:
        return HistorialMapaScreen();
    }
  }
}