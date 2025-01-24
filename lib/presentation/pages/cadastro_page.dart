import 'package:app_gerenciamento_de_tarefas/data/model/model.dart';
import 'package:app_gerenciamento_de_tarefas/data/repository/tarefaRepository.dart';
import 'package:app_gerenciamento_de_tarefas/presentation/viewmodel/tarefaViewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CadastroTarefa extends StatefulWidget {
  const CadastroTarefa({super.key});

  @override
  State<CadastroTarefa> createState() => _CadastroTarefaState();
}

class _CadastroTarefaState extends State<CadastroTarefa> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final statusController = TextEditingController();
  final dataInicioController = TextEditingController();
  final dataFimController = TextEditingController();
  final TarefaViewmodel _viewModel = TarefaViewmodel(TarefaRepository());

  Future<void> saveTarefa() async {
    if (_formKey.currentState!.validate()) {
      final tarefa = Tarefa(
        nome: nomeController.text,
        descricao: descricaoController.text,
        status: statusController.text,
        dataInicio: dataInicioController.text,
        dataFim: dataFimController.text,
      );
      // print(dog.toMap());
      await _viewModel.addTarefa(tarefa);

      // Verifica se o widget ainda está montado antes de exibir o Snackbar ou navegar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarefa adicionado com sucesso!')),
        );
        Navigator.pop(context); // Fecha a página após salvar
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Tarefas'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Cadastrar uma Tarefa',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: nomeController,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            labelStyle: TextStyle(color: Colors.teal.shade700),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.teal.shade700),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor entre com um nome';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: descricaoController,
                          decoration: InputDecoration(
                            labelText: 'Descricao',
                            labelStyle: TextStyle(color: Colors.teal.shade700),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.teal.shade700),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor entre com a idade';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Por favor entre com um número válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: saveDog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 30.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          icon: const Icon(Icons.save, size: 24),
                          label: const Text(
                            'Salvar',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
