import 'package:flutter/material.dart';
import 'package:projeto_aplicado/capacitacao/domain/entity/capacitacao.dart';
import 'package:projeto_aplicado/funcao/domain/entity/funcao.dart';

class CapacitacaoList extends StatefulWidget {
  const CapacitacaoList({super.key});

  @override
  State<CapacitacaoList> createState() => _CapacitacaoListState();
}

class _CapacitacaoListState extends State<CapacitacaoList> {

  List<Capacitacao> roles = [
      Capacitacao(
        id: 1, 
        name: "Analise e desenvolvimento de soluções SAP", 
        workload: 48, 
        validty: "12/10/2024", 
        companyId: 2
      ),
      Capacitacao(
        id: 2, 
        name: "Análise de requisitos e desenvolvimento de projetos", 
        workload: 32, 
        validty: "25/11/2023", 
        companyId: 1
      )
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