import 'package:app_gerenciamento_de_tarefas/data/repository/tarefaRepository.dart';
import 'package:app_gerenciamento_de_tarefas/presentation/pages/cadastro_page.dart';
import 'package:app_gerenciamento_de_tarefas/presentation/pages/tarefa_edit_page.dart';
import 'package:app_gerenciamento_de_tarefas/presentation/viewmodel/tarefaViewmodel.dart';
import 'package:flutter/material.dart';

import '../../data/model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Tarefa> _tarefas = [];
  final TarefaViewmodel _viewModel = TarefaViewmodel(TarefaRepository());
  Tarefa? _lastDeletedTarefa;

  @override
  void initState() {
    super.initState();
    _loadTarefas();
  }

  Future<void> _loadTarefas() async {
    _tarefas = await _viewModel.getTarefa();
    
    

    // Função para converter datas no formato "DD/MM/AAAA"
    DateTime parseCustomDate(String date) {
      final parts = date.split('/');
      if (parts.length == 3) {
        return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      }
      throw FormatException('Formato de data inválido: $date');
    }

    // Ordenar a lista de tarefas pela data de início
    _tarefas.sort((a, b) {
      // Converter as strings de dataInicio para DateTime
      DateTime dataA = parseCustomDate(a.dataInicio);
      DateTime dataB = parseCustomDate(b.dataInicio);
      // Comparar as datas
      return dataA.compareTo(dataB);
    });

    if (mounted) {
      setState(() {});
    }
  }
 
  

  Future<void> _deleteTarefa(Tarefa tarefa) async {
    await _viewModel.deleteTarefa(tarefa.id!);
    _lastDeletedTarefa = tarefa;

    final snackBar = SnackBar(
      content: Text('${tarefa.nome} deletado'),
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () {
          if (_lastDeletedTarefa != null && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Desfeita a exclusão de ${_lastDeletedTarefa!.nome}'),
            ));
            _viewModel.addTarefa(_lastDeletedTarefa!);
            setState(() {
              _tarefas.add(_lastDeletedTarefa!);
              _lastDeletedTarefa = null;
            });
          }
        },
      ),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    await _loadTarefas();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pendente':
        return Colors.orange;
      case 'Em andamento':
        return Colors.blue;
      case 'Concluída':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Tarefas'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Cadastro de Tarefas'),
              onTap: () {
                Navigator.pushNamed(context, '/CadastroTarefa');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _tarefas.isEmpty
            ? const Center(child: Text('Nenhuma tarefa disponível.'))
            : ListView.builder(
          itemCount: _tarefas.length,
          itemBuilder: (context, index) {
            final tarefa = _tarefas[index];
            return Card(
              elevation: 5, // Sombra para o card
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Bordas arredondadas
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    tarefa.nome[0], // Primeira letra do nome
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  tarefa.nome,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                Text('Descrição: ${tarefa.descricao}'),
                const SizedBox(height: 4), // Espaço vertical entre os textos
                Row(
                  children: [
                    Text('Início: ${tarefa.dataInicio}'),
                    const SizedBox(width: 16), // Espaço horizontal entre "Início" e "Fim"
                    Text('Fim: ${tarefa.dataFim}'),
                  ],
                ),
                const SizedBox(height: 4), // Espaço vertical entre os textos
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alinha o status e os ícones
                    children: [
                      Container(color: _getStatusColor(tarefa.status),
              child: Text('Status: ${tarefa.status}'),),
                Row(
                  mainAxisSize: MainAxisSize.min, // Evita que o Row ocupe todo o espaço
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TarefaEditPage(tarefa: tarefa),
                            ),
                          ).then((_) => _loadTarefas());
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteTarefa(tarefa);
                      },
                    ),
                  ],
                ),
                ]
              ),
            ]
            )
              )
            );
          },
        ),
      ),
    );
  }
}

