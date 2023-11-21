class Colaborador {
  int id;
  String name;
  int contactNumber;
  int role;
  String admissionDate;
  bool trainingCompleted = false;

  Colaborador({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.role,
    required this.admissionDate,
  });

  factory Colaborador.fromMap(Map<String, dynamic> data) {
    return Colaborador(
      id: int.parse(data["id"]), 
      name: data["name"], 
      contactNumber: int.parse(data["contact_number"]), 
      role: int.parse(data["role"]), 
      admissionDate: data["admission_date"]
    );
  }
}