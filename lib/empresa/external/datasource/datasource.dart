import 'package:projeto_aplicado/empresa/domain/entity/empresa.dart';

class EmpresaDatasource {

  Future<List<Empresa>> getCompanies() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
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
  } 
  
}