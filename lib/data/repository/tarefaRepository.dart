import 'package:sqflite/sqflite.dart';

import '../../core/database.dart';
import '../model/model.dart';

class TarefaRepository {
  Future<void> insertTarefa(Tarefa tarefa) async {
    final db = await DatabaseHelper.initDb();
    await db.insert(
      'tarefa',
      tarefa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Tarefa>> getTarefa() async {
    final db = await DatabaseHelper.initDb();
    final List<Map<String, Object?>> tarefaMaps = await db.query('tarefa');
    return tarefaMaps.map((map) {
      return Tarefa(
          id: map['id'] as int,
          nome: map['nome'] as String,
          descricao: map['descricao'] as String,
          status: map['status'] as String,
          dataInicio: map['dataInicio'] as String,
          dataFim: map['dataFim'] as String);
    }).toList();
  }

  Future<void> updateTarefa(Tarefa tarefa) async {
    final db = await DatabaseHelper.initDb();
    await db.update(
      'tarefa',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  Future<void> deleteTarefa(int id) async {
    final db = await DatabaseHelper.initDb();
    await db.delete(
      'tarefa',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
