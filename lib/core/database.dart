import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> initDb() async {
    return openDatabase(
        join(await getDatabasesPath(), 'tarefa_database.db'),
        version: 1,
        onCreate: (db, version) async {
          // Criação da tabela
          await db.execute(
              'CREATE TABLE tarefa(id INTEGER PRIMARY KEY, nome TEXT, descricao TEXT, status TEXT, dataInicio TEXT, dataFim TEXT)'
          );
        }
    );
  }
}


