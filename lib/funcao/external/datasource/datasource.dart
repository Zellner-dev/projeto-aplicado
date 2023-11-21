import 'package:projeto_aplicado/funcao/domain/entity/funcao.dart';

class FuncaoDatasource {

  Future<List<Funcao>> getRoles() async {
    return [
      Funcao(id: 1, name: "Arquiteto de Software", idCapacitacao: 2),
      Funcao(id: 2, name: "Analista SAP", idCapacitacao: 1),
    ];
  }
}