import 'dart:io';

//los que se importaron desde el puspec
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

//propios paquetes
import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider{
  
  /*
    Esta clase esta diseñada como un Singleton (instancia única), con el fin de 
    que una clase sólo tenga una instancia y proporcionar un punto de acceso global a ella.
    Solo exista una instancia en todo el proyecto.

    Para que una clase se a un Singleton

     *1. El cosntructor debe ser privado, para que nadie lo pueda instanciar.
     *2. Para instanciar el objeto (ya que el constructor es privado), se hace a través de un método público y
         estático. En este método se revisa si el objeto ha sido instanciado antes. Si no ha sido 
         instanciado, llama al constructor y guarda el objeto creado en una variable estática del 
         objeto. Si el objeto ya fue instanciado anteriormente, lo que hace este método es devolver la 
         referencia al estado creado anteriormente.

   */


  static  Database? _database; //Objeto de la base de datos
  static final DBProvider db = DBProvider._(); //instancia del singleton

  //Se crea el osntructor privador
  DBProvider._();

  Future<Database?> get getDatabase async{

    //2. Valdiar si el objeto ya fue instnaciado, para devovler la referencia al objeto ya instanciado
    if(_database != null)
        return _database;
    
    //2.1 es la primera vez que se instancia
      _database = await initDB();

      return _database;

     
  }

  Future<Database> initDB() async{

    //Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    //El join viene del import 'package:path/path.dart';
    final path = join(documentsDirectory.path,'ScansDB.db');
    //print('path BD: '+path);

    //Crear la base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int Version) async{

        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          );
        ''');
      }
      );  
  }

  //Forma 1 de hacer un insert (en crudo)
  Future<int> nuevoScanRaw( ScanModel nuevoScan) async{

    final id    = nuevoScan.id;
    final tipo  = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    //Obtener referencia a la base de datos
    //Debe esperar a que la base de datos este lista
    final db = await getDatabase; 

    //A los textos hay que mandarlos entre ''
    final res = await db!.rawInsert('''
      INSERT INTO Scans (id,tipo,valor) values ($id,'$tipo','$valor');
    ''');


    return res;
  }

  //Forma 2 de hacer un isnert
  Future<int> nuevoScan ( ScanModel nuevoScan ) async{

    final db = await getDatabase;

    //Primer párametro, el nombre de la tabla
    //Segundo recibe un Map con los valores. Gracias al modelo que se creo (scan_model), tenemos el
    //método toJson que convierta la instancia a un Map

    final res = await db!.insert('Scans', nuevoScan.toJson());

    //Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    //El join viene del import 'package:path/path.dart';
    final path = join(documentsDirectory.path,'ScansDB.db');
    
    print('path BD: '+path);
    print(res);

    return res;

  }

  //Selects

  Future<ScanModel?>  getScanByID (int id) async{

    final db  = await getDatabase;
    //final res = await db!.query('Scans'); // select * from
    final res = await db!.query('Scans',where: 'id = ?',whereArgs: [id]);

    return res.isNotEmpty
            ? ScanModel.fromJson(res.first)
            : null;
  }

  Future<List<ScanModel>?> getAllScans () async{

    final db  = await getDatabase;
    final res = await db!.query('Scans');

    return res.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  //Con RawQuery
  Future<List<ScanModel>?> getScansByTipo ( String tipo) async{

    final db  = await getDatabase;
    final res = await db!.rawQuery('''
    SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  //update
  Future<int> updateScan ( ScanModel scan) async{
    final db = await getDatabase;
    final res = await db!.update('Scans', scan.toJson(),where: 'id = ?',whereArgs: [scan.id]);

    return res;

  }

  //Deletes

  Future<int> deleteScan (int ID) async{
    final db = await getDatabase;
    final res = await db!.delete('Scans',where: 'id = ?', whereArgs: [ID]);

    return res;
  }

  Future<int> deleteAllScan () async{
    final db = await getDatabase;
    final res = await db!.rawDelete('''
      DELETE FROM Scans;
    ''');

    return res;
  }

}