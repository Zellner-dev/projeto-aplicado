import 'package:flutter/material.dart';
import 'package:projeto_aplicado/funcao/domain/entity/funcao.dart';

class FuncaoList extends StatefulWidget {
  const FuncaoList({super.key});

  @override
  State<FuncaoList> createState() => _FuncaoListState();
}

class _FuncaoListState extends State<FuncaoList> {

  List<Funcao> roles = [
    Funcao(id: 1, name: "Arquiteto de Software", idCapacitacao: 2),
    Funcao(id: 2, name: "Analista SAP", idCapacitacao: 1),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Função"),
      ),
      body: ListView.builder(
        itemCount: roles.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text(roles[index].name),
            trailing: const Icon(Icons.arrow_right),
          ),
        ),
      ),
    );
  }
}