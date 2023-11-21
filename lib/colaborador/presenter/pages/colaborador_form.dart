import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_aplicado/colaborador/presenter/provider/colaborador_provider.dart';
import 'package:provider/provider.dart';

class ColaboradorForm extends StatefulWidget {
  const ColaboradorForm({super.key});

  @override
  State<ColaboradorForm> createState() => _ColaboradorFormState();
}

class _ColaboradorFormState extends State<ColaboradorForm> {

  final TextEditingController dateCotnroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _data = {};
  DateTime pickedDate = DateTime.now(); 
  late String selectedValue;
  int index = 0;

   @override
  void initState() {
    super.initState();
    selectedValue = items[0];
    _data["admission_date"] = getDate;
    _data["role"] = (1).toString();
  }

  final List<String> items = [
    "Arquiteto de Software",
    "Analista SAP",
  ];


  void _submit() {
    if(!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    Provider.of<ColaboradorProvider>(context, listen: false).create(_data);
    Navigator.of(context).pop();
  }

  void _pickDate() async {
    final date = await showDialog(context: context, builder: (context) => DatePickerDialog(
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020, 1, 1), 
      lastDate: DateTime.now(),
    ));
    setState(() {
      pickedDate = date;
    });
    _data["admission_date"] = getDate;
  }

  String get getDate {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy"); 
    return dateFormat.format(pickedDate);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de colaborador"),
        actions: [
          IconButton(
            onPressed: _submit, 
            icon: const Icon(Icons.check_rounded)
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Matricula")
                ),
                onSaved: (value) => _data["id"] = value,
                validator: (value) {
                  value = value ?? "";
                  if(value.isEmpty) return "Esse campo não pode ser vazio.";
                  try{
                    int.parse(value);
                  } catch (_) {
                    return "O campo precisa ser um número.";
                  }
                  if(value.length != 6) {
                    return "O número precisa ter 6 caractéres";
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Nome completo")
                ),
                onSaved: (value) => _data["name"] = value,
                validator: (value) {
                  value = value ?? "";
                  if(value.isEmpty) return "Esse campo não pode ser vazio.";
                },
              ),
              TextFormField(
                maxLength: 11,
                decoration: const InputDecoration(
                  label: Text("Numero de contato")
                ),
                onSaved: (value) => _data["contact_number"] = value,
                validator: (value) {
                  value = value ?? "";
                  if(value.isEmpty) return "Esse campo não pode ser vazio.";
                  try{
                    int.parse(value);
                  } catch (_) {
                    return "O campo precisa ser um número.";
                  }
                  if(value.length != 11) {
                    return "O número precisa ter 11 caractéres";
                  }
                },
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Row(
                    children: const [
                      Icon(
                        Icons.list,
                        size: 16,
                    
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
        
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: items.map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    ),
                  ))
                  .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      index = items.indexWhere((element) => element == value);
                      selectedValue = value!;
                    });
                    _data["role"] = (index + 1).toString();
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  _pickDate();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Data de admissão", style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Text(getDate)
                  ],
                ),
                // child: TextFormField(
                //   controller: dateCotnroller,
                //   decoration: const InputDecoration(
                //     label: Text("Data de admissão")
                //   ),
                //   onSaved: (value) => _data["admission_date"] = value,
                //   validator: (value) {
                //     value = value ?? "";
                //     if(value.isEmpty) return "Esse campo não pode ser vazio.";
                //   },
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
