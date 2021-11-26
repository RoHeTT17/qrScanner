
import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  /* Este es un servicio centralizado, donde vamos a buscar toda la info de los Scans.
   * Aquí actualiza la UI, por eso no se obtiene de forma directa la información del db_provider
   */

   List<ScanModel>  scans = [];
   //opción seleccionada
   String tipoSeleccionado = 'http';

   nuevoScan (String valor) async {

     //se crea la instancia del objeto
     final nuevoScan = new ScanModel(valor: valor);

     //insertar en la BD
     final id = await DBProvider.db.nuevoScan(nuevoScan);
     //al isnertar el BD nos regresa el id que se genero, ahora, se debe asignar ese ID al objeto que se creo
     nuevoScan.id = id;

     //Agregarlo a la lista de los Scans (a un no se refresca la UI)
     //solo se agregan cuando es igual al tipo seleccionado
     if(this.tipoSeleccionado == nuevoScan.tipo) {
       this.scans.add(nuevoScan);

       //notificar a los listener que se hizo un cambio, para que los widget se redibujen
       notifyListeners();
     }
   }

   cargarAllScans() async{
     final scans = await DBProvider.db.getAllScans();
     this.scans = [...scans!];
     //this.scans = scans!;
     notifyListeners();
   }

   cargarScanByType(String tipo) async{
     final scans = await DBProvider.db.getScansByTipo(tipo);
     this.scans = [...scans!];
     this.tipoSeleccionado = tipo;
     notifyListeners();
   }

   borrarTodos() async{
     await DBProvider.db.deleteAllScan();
     this.scans = [];
     notifyListeners();
   }

   borrarScanPorID (int id) async{
     await DBProvider.db.deleteScan(id);

     //Para evitar la fatiga se manda llamar el proceso para garlos, el tipo es el que esta definido arriba
      //Como se elimina visualmente no es necesario recargar
     //this.cargarScanByType(this.tipoSeleccionado);


   }

}