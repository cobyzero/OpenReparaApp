import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/services/homeService.dart';

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
                home: true,
                title: "OpenRepair",
              ),
              SizedBox(
                  width: double.infinity,
                  height: 450,
                  child: FutureBuilder(
                    future: HomeService.getHome(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView(
                          padding: const EdgeInsets.all(20),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
                          children: [
                            containerSeccion("Clients", Colors.green, snapshot.data![0], () {
                              Navigator.pushNamed(context, "clientes").then((_) => setState(() {}));
                            }),
                            containerSeccion("Inventory", Colors.blue, snapshot.data![1], () {
                              Navigator.pushNamed(context, "inventorio")
                                  .then((_) => setState(() {}));
                            }),
                            containerSeccion("Orders", Colors.red, snapshot.data![2], () {
                              Navigator.pushNamed(context, "ordenes").then((_) => setState(() {}));
                            }),
                            containerSeccion("Sales", Colors.amber, "S/.${snapshot.data![3]}", () {
                              Navigator.pushNamed(context, "ventas");
                            }),
                          ],
                        );
                      } else {
                        return GridView(
                          padding: const EdgeInsets.all(20),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
                          children: [
                            containerSeccion("Clients", Colors.green, "0", () {
                              Navigator.pushNamed(context, "clientes");
                            }),
                            containerSeccion("Inventory", Colors.blue, "0", () {
                              Navigator.pushNamed(context, "inventorio");
                            }),
                            containerSeccion("Orders", Colors.red, "0", () {
                              Navigator.pushNamed(context, "ordenes");
                            }),
                            containerSeccion("Sales", Colors.amber, "0", () {
                              Navigator.pushNamed(context, "ventas");
                            }),
                          ],
                        );
                      }
                    },
                  )),
              const MyCredits()
            ],
          ),
        ),
      ),
    ));
  }

  containerSeccion(String title, Color color, String number, Function() fun) {
    return InkWell(
      onTap: fun,
      child: Container(
        width: 140,
        height: 120,
        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              number,
              style: TextStyle(fontSize: 45, color: color),
            )
          ],
        ),
      ),
    );
  }
}
