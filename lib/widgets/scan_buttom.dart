import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scans_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButtom extends StatelessWidget {
//  const ScanButtom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async{

            //Para el dispositivo físico
            String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                                                                '#3D8BEF', //Linea del scan
                                                                'Cancelar', 
                                                                false, 
                                                                ScanMode.QR);

            //Para hacer pruebas con el emulador
            //final barcodeScanRes = 'https://fernando-herrera.com';
            //final barcodeScanRes = 'geo:20.516090684608155,-100.80376872579791';

            //Si es -1, significa que el usuario cancelo
            if (barcodeScanRes == '-1')
              return;

            //Cuando el provider esta dentro de un método (en este caso onTap) no se debe redibujar, porque sino marca error.
            final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

            //scanListProvider.nuevoScan(barcodeScanRes);
            //scanListProvider.nuevoScan('geo:15.33,15.66');

            final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

            launchURL(context, nuevoScan);

      });
  }
}