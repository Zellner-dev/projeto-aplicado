import 'package:flutter/material.dart';
import 'package:projeto_aplicado/capacitacao/domain/entity/capacitacao.dart';
import 'package:projeto_aplicado/capacitacao/external/datasource/datasource.dart';
import 'package:projeto_aplicado/colaborador/domain/entity/colaborador.dart';
import 'package:projeto_aplicado/colaborador/presenter/provider/colaborador_provider.dart';
import 'package:projeto_aplicado/common/format/number_format.dart';
import 'package:projeto_aplicado/empresa/domain/entity/empresa.dart';
import 'package:projeto_aplicado/empresa/external/datasource/datasource.dart';
import 'package:projeto_aplicado/funcao/domain/entity/funcao.dart';
import 'package:projeto_aplicado/funcao/presenter/provider/funcao_provider.dart';
import 'package:provider/provider.dart';

class ColaboradorInfo extends StatefulWidget {

  final Colaborador colaborador;

  const ColaboradorInfo({super.key, required this.colaborador});

  @override
  State<ColaboradorInfo> createState() => _ColaboradorInfoState();
}

class _ColaboradorInfoState extends State<ColaboradorInfo> {

  late Empresa company;
  late Capacitacao training;
  bool disposed = false;

  bool loadingInfo = true;

  @override
  void initState() {
    super.initState();
    setCompany();
  }

  @override
  void dispose() {
    super.dispose();
    disposed = true;
  }

  void setCompany() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Empresa> companies = await EmpresaDatasource().getCompanies();
    List<Capacitacao> trainings = await CapacitacaoDatasource().getTrainings();
    Funcao role = getRole(widget.colaborador.role);
    training = trainings.firstWhere((element) => element.id == role.idCapacitacao);
    company = companies.firstWhere((element) => element.id == training.companyId);
    if(!disposed) {
      setState(() => loadingInfo = false);
    }
  }

  Funcao getRole(int id) {
    final role = Provider.of<FuncaoProvider>(context, listen: false).roles.firstWhere(
      (role) => role.id == id);
    return role;
  }
  
  String getRoleName(int id) {
    final role = Provider.of<FuncaoProvider>(context, listen: false).roles.firstWhere(
      (role) => role.id == id);
    return role.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informações do colaborador"),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ColaboradorProvider>(context, listen: false).delete(widget.colaborador.id);
              Navigator.pop(context);
            }, 
            icon: const Icon(Icons.delete, color: Colors.red,)
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Informações",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Matricula: ", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.colaborador.id.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Nome: ", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.colaborador.name),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Contato: ", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(NumberFormat.format(widget.colaborador.contactNumber)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Função: ", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(getRoleName(widget.colaborador.role)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Data de admissão: ", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.colaborador.admissionDate.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Capacitação",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          loadingInfo 
          ? const Center(child: CircularProgressIndicator(),)
          : Card(
            margin: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Nome: ", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(training.name),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Validade: ", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(training.validty),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Carga horária: ", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${training.workload}h"),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Empresa: ", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(company.name),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Endereço: ", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(company.address),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          widget.colaborador.trainingCompleted
          ? Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Center(
              child: Text("Capacitação em dia",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
          )
          : Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<ColaboradorProvider>(context, listen: false).setTraining(
                  widget.colaborador.id
                );
                setState(() {
                  widget.colaborador.trainingCompleted = true;
                });
              },
              child: const Text("Concluir capacitação"),
            ),
          )
        ],
      ),
    );
  }
}