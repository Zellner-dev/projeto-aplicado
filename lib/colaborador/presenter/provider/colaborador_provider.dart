import 'package:flutter/material.dart';
import 'package:projeto_aplicado/colaborador/domain/entity/colaborador.dart';
import 'package:projeto_aplicado/services/database/app_database.dart';

class ColaboradorProvider extends ChangeNotifier {

  final AppDatabase appDatabase = AppDatabase();
  List<Colaborador> colaboradores = [
    Colaborador(
      id: 123456, 
      name: "Alisson Zellner", 
      contactNumber: 45912345678, 
      role: 1, 
      admissionDate: "12/10/2022"
    )
  ];

  Future<void> create(Map<String, dynamic> data) async {
    final colaborador = Colaborador.fromMap(data);
    colaboradores.add(colaborador);
    print(colaboradores.length);
    notifyListeners();
  }

  Future<List<Colaborador>> get() async {
    // notifyListeners();
    return [];
  }

  Future<void> delete(int id) async {
    colaboradores.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> update(Map<String, dynamic> data) async {
    
  }

  void setTraining(int id) {
    final colaborador = colaboradores.firstWhere((element) => element.id == id);
    colaborador.trainingCompleted = true;
    notifyListeners();
  }
}