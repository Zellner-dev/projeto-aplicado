// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:projeto_aplicado/colaborador/presenter/pages/colaborador_form.dart';
import 'package:projeto_aplicado/colaborador/presenter/pages/colaborador_info.dart';
import 'package:projeto_aplicado/colaborador/presenter/provider/colaborador_provider.dart';
import 'package:projeto_aplicado/empresa/domain/entity/empresa.dart';
import 'package:projeto_aplicado/empresa/external/datasource/datasource.dart';
import 'package:projeto_aplicado/funcao/presenter/provider/funcao_provider.dart';
import 'package:provider/provider.dart';

class EmpresaList extends StatefulWidget {
  const EmpresaList({super.key});

  @override
  State<EmpresaList> createState() => _EmpresaListState();
}

class _EmpresaListState extends State<EmpresaList> {

  List<Empresa> companies = [
    Empresa(
      id: 1, 
      name: "UNISENAI Cursos", 
      contactNumber: 47912345678, 
      address: "Rua dos Cursos, 9001"
    ),
    Empresa(
      id: 2, 
      name: "UNIESQUINA Capacitações", 
      contactNumber: 47987654321, 
      address: "Rua das esquinas, 103"
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
        title: const Text("Empresa"),
      ),
      body: ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text(companies[index].name),
            subtitle: Text(companies[index].address),
            trailing: const Icon(Icons.arrow_right),
          ),
        ),
      ),
    );
  }
}