// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:projeto_aplicado/colaborador/presenter/pages/colaborador_form.dart';
import 'package:projeto_aplicado/colaborador/presenter/pages/colaborador_info.dart';
import 'package:projeto_aplicado/colaborador/presenter/provider/colaborador_provider.dart';
import 'package:projeto_aplicado/funcao/presenter/provider/funcao_provider.dart';
import 'package:provider/provider.dart';

class ColaboradoresList extends StatefulWidget {
  const ColaboradoresList({super.key});

  @override
  State<ColaboradoresList> createState() => _ColaboradoresListState();
}

class _ColaboradoresListState extends State<ColaboradoresList> {

  bool isLoading = true;
  bool disposed = false;

  @override
  void initState() {
    super.initState();
    getColaboradores();
  }
  
  @override
  void dispose() {
    super.dispose();
    disposed = true;
  }

  Future<void> getColaboradores() async {
    await Provider.of<ColaboradorProvider>(context, listen: false).get();
    await Provider.of<FuncaoProvider>(context, listen: false).getRoles();
    await Future.delayed(const Duration(seconds: 1));
    if(!disposed) {
      setState(() {
        isLoading = false;
      });
    }
  }

  String getRoleName(int id) {
    final role = Provider.of<FuncaoProvider>(context, listen: false).roles.firstWhere(
      (role) => role.id == id);
    return role.name;
  }

  @override
  Widget build(BuildContext context) {
    final colaboradorProvider = Provider.of<ColaboradorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Colaboradores"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ColaboradorForm())
            ), 
            icon: const Icon(Icons.add)
          )
        ],
      ),
      body: isLoading 
      ? const Center(child: CircularProgressIndicator())
      : colaboradorProvider.colaboradores.isEmpty
      ? const Center(
        child: Text("Nenhum colaborador criado"),
      )
      : ListView.builder(
        itemCount: colaboradorProvider.colaboradores.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ColaboradorInfo(
                  colaborador: colaboradorProvider.colaboradores[index]
                ),
              )
            ),
            title: Text(colaboradorProvider.colaboradores[index].name),
            subtitle: Text(
              getRoleName(colaboradorProvider.colaboradores[index].role)
            ),
            trailing: colaboradorProvider.colaboradores[index].trainingCompleted
            ? const Icon(Icons.check, color: Colors.green,)
            : const Icon(Icons.warning, color: Colors.red,),
          ),
        ),
      ),
    );
  }
}