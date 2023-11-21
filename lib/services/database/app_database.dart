import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class AppDatabase {

  Future<void> start() async  {
    Database database = await getDatabase();
    database.execute("""
      CREATE IF NOT EXISTS TABLE COLABORADORES(
        ID INTEGER PRIMARY KEY,
        NAME TEXT,
        CONTATO INTEGER,
        FUNCAO TEXT,
        DATA_ADMISSAO TEXT
      )
    """);
    await database.close();
  }

  Future<Database> getDatabase() async {
    DatabaseFactory  factory = databaseFactoryFfiWeb;
    Database database = await factory.openDatabase('app.db');
    return database;
  }
}