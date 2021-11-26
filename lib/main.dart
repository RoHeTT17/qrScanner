import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/mapa_page.dart';

import 'package:qr_reader/providers/scans_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //El create, es la instrucción que se va a ejecutar cuando no hay ninguna instancia del provider creado
        //para el evento de cuando se cambia en navigator
        ChangeNotifierProvider(create: (context) => new UiProvider()),
        //Provider de los Scans (hace de puente entre la UI y la BD)
        ChangeNotifierProvider(create: ( _ ) => new ScanListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home' : ( _ ) => HomeScreen(),
          'mapa' : ( _ ) => MapaScreen()
        },
        /*theme: ThemeData.light().copyWith(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple
          )
        ),*/
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          //appBarTheme: AppBarTheme(color: Colors.deepPurpleAccent),
          floatingActionButtonTheme: 
                FloatingActionButtonThemeData(
                                  backgroundColor: Colors.deepPurple
                                  ),
        )
      ),
    );
  }
}