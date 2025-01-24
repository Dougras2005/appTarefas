import 'package:app_gerenciamento_de_tarefas/data/repository/tarefaRepository.dart';

import '../../data/model/model.dart';

class TarefaViewmodel {
  final TarefaRepository repository;

  TarefaViewmodel(this.repository);

  Future<void> addTarefa(Tarefa tarefa) async {
    await repository.insertTarefa(tarefa);
  }

  Future<List<Tarefa>> getTarefa() async {
    return await repository.getTarefa();
  }

  Future<void> updateTarefa(Tarefa tarefa) async {
    await repository.updateTarefa(tarefa);
  }

  Future<void> deleteTarefa(int? id) async {
    await repository.deleteTarefa(id!);
  }
}
