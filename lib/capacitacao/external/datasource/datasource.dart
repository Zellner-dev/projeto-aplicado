import 'package:projeto_aplicado/capacitacao/domain/entity/capacitacao.dart';

class CapacitacaoDatasource {

  Future<List<Capacitacao>> getTrainings() async {
    Future.delayed(const Duration(milliseconds: 500));
    return [
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
  }
}