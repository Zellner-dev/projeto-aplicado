import 'package:flutter/material.dart';
import 'package:projeto_aplicado/funcao/domain/entity/funcao.dart';
import 'package:projeto_aplicado/funcao/external/datasource/datasource.dart';

class FuncaoProvider extends ChangeNotifier {

  FuncaoDatasource datasource = FuncaoDatasource();
  List<Funcao> roles = [];
  
  Future<void> getRoles() async {
    roles = await datasource.getRoles();
  }
}