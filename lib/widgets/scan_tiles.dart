import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scans_list_provider.dart';

class ScanTiles extends StatelessWidget {

  final String tipo;

  const ScanTiles({Key? key,required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
            leading: Icon(
              this.tipo == 'http'
              ? Icons.home_outlined
              : Icons.map_outlined,
              color: Theme.of(context).primaryColor,),
            title: Text(scanListProvider.scans[index].valor),
            subtitle: Text('ID: '+scanListProvider.scans[index].id.toString()),
            trailing: Icon (Icons.keyboard_arrow_right),
            onTap: (){},
          ),
        )
    );
  }
}

