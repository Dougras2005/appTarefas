import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/model/model.dart';
import '../../data/repository/tarefaRepository.dart';
import '../viewmodel/tarefaViewmodel.dart';

class TarefaEditPage extends StatefulWidget {
  final Tarefa tarefa;

  const TarefaEditPage({super.key, required this.tarefa});

  @override
  State<TarefaEditPage> createState() => _TarefaEditPageState();
}

class _TarefaEditPageState extends State<TarefaEditPage> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final statusController = TextEditingController();
  final descricaoController = TextEditingController();
  final dataInicioController = TextEditingController();
  final dataFimController = TextEditingController();
  final TarefaViewmodel _viewModel = TarefaViewmodel(TarefaRepository());

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.tarefa.nome;
    descricaoController.text = widget.tarefa.descricao;
    dataInicioController.text = widget.tarefa.dataInicio;
    dataFimController.text = widget.tarefa.dataFim.toString();
  }

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    dataInicioController.dispose();
    dataFimController.dispose();
    super.dispose();
  }

  updateTarefa() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedTarefa = Tarefa(
        id: widget.tarefa.id, // Mantém o ID original
        nome: nomeController.text,
        status: statusController.text,
        descricao: descricaoController.text,
        dataInicio: dataInicioController.text,
        dataFim: dataFimController.text,
      );

      await _viewModel.updateTarefa(updatedTarefa);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarefa atualizado com sucesso!')),
        );
        Navigator.pop(context, updatedTarefa); // Retorna o tarefa atualizado
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edição Dog'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Editar Dog',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nomeController,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor entre com um nome';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: descricaoController,
                        decoration: InputDecoration(
                          labelText: 'Descrição',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor entre com uma descrição';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: dataInicioController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'Data de Fim',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today, color: Colors.blue),
                            onPressed: () async {
                              // Abre o date picker e aguarda a seleção da data
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), // Data inicial (hoje)
                                firstDate: DateTime(2000), // Data mínima permitida
                                lastDate: DateTime(2101), // Data máxima permitida
                              );

                              // Se o usuário selecionar uma data, atualiza o campo
                              if (pickedDate != null) {
                                // Formata a data para o formato desejado (opcional)
                                String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                dataFimController.text = formattedDate; // Atualiza o controlador
                              }
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, selecione a data de fim';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: dataFimController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'Data de Fim',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today, color: Colors.blue),
                            onPressed: () async {
                              // Abre o date picker e aguarda a seleção da data
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), // Data inicial (hoje)
                                firstDate: DateTime(2000), // Data mínima permitida
                                lastDate: DateTime(2101), // Data máxima permitida
                              );

                              // Se o usuário selecionar uma data, atualiza o campo
                              if (pickedDate != null) {
                                // Formata a data para o formato desejado (opcional)
                                String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                dataFimController.text = formattedDate; // Atualiza o controlador
                              }
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, selecione a data de fim';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: updateTarefa,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
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
                          'Salvar Alterações',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

