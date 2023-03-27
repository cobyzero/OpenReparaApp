import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/creditos.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyAppBar(
                title: "OpenRepara",
              ),
              SizedBox(
                width: double.infinity,
                height: 450,
                child: GridView(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
                  children: [
                    containerSeccion("clientes", Icons.person, 2, "Registrados", () {
                      Navigator.pushNamed(context, "clientes");
                    }),
                    containerSeccion("inventario", Icons.inventory_2, 1, "Registrados", () {
                      Navigator.pushNamed(context, "inventorio");
                    }),
                    containerSeccion("ordenes", Icons.description, 1, "Registrados", () {
                      Navigator.pushNamed(context, "ordenes");
                    }),
                    containerSeccion("ventas", Icons.payment, 800, "S/.", () {
                      Navigator.pushNamed(context, "ventas");
                    }),
                  ],
                ),
              ),
              const MyCreditos()
            ],
          ),
        ),
      ),
    ));
  }

  containerSeccion(String titulo, IconData icon, int numero, String texto, Function() fun) {
    return InkWell(
      onTap: fun,
      child: Container(
        width: 140,
        height: 120,
        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              titulo.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(
              icon,
              size: 40,
              color: Colors.blue,
            ),
            Text("$numero $texto")
          ],
        ),
      ),
    );
  }
}
