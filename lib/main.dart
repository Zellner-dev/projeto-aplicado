import 'package:flutter/material.dart';
import 'package:projeto_aplicado/capacitacao/presenter/pages/capacitacao_list.dart';
import 'package:projeto_aplicado/colaborador/presenter/pages/colaboradores_list.dart';
import 'package:projeto_aplicado/colaborador/presenter/provider/colaborador_provider.dart';
import 'package:projeto_aplicado/empresa/presenter/pages/empresa_list.dart';
import 'package:projeto_aplicado/funcao/presenter/pages/funcao_list.dart';
import 'package:projeto_aplicado/funcao/presenter/provider/funcao_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ColaboradoresList(),
    EmpresaList(),
    CapacitacaoList(),
    FuncaoList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ColaboradorProvider()),
      ChangeNotifierProvider(create: (context) => FuncaoProvider())
    ],
    child: MaterialApp(
      title: 'Projeto Aplicado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Empresas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Capacitações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Funções',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    )),
    ); 
  }
}

