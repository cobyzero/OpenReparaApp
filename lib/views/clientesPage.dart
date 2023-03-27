import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/dataTable.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/textFormField.dart';
import 'package:openrepara_app/models/clientesModel.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  List<String> columns = ["Codigo", "Nombre", "Correo", "Telefono", "Acciones"];
  List<ClientesModel> data = [
    ClientesModel(0, "KDOS1", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS2", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS1", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS2", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS1", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS2", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS", "Sebastian", "edyne@dasd.com", "832732832"),
    ClientesModel(0, "KDOS", "Sebastian", "edyne@dasd.com", "832732832"),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              MyAppBar(
                title: "Clientes",
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MyTextFormField(texto: "Buscar por Codigo", icon: Icons.person),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            data = data.where((element) => element.codigo == "KDOS").toList();
                          });
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: MyDataTable(columns: MyDataTable.getColumns(columns), rows: getRows(data)),
              )),
              const MyCreditos()
            ],
          ),
        ),
      ),
    );
  }

  getRows(List<ClientesModel> data) {
    List<DataRow> rows = [];
    for (var element in data) {
      rows.add(DataRow(cells: [
        DataCell(Text(element.codigo)),
        DataCell(Text(element.nombre)),
        DataCell(Text(element.correo)),
        DataCell(Text(element.telefono)),
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                editCliente(element);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  data.remove(element);
                });
              },
            )
          ],
        ))
      ]));
    }
    return rows;
  }

  editCliente(ClientesModel clientesModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Editar Cliente ${clientesModel.codigo}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              MyTextFormField(
                texto: "Nombre",
                style: false,
              ),
              MyTextFormField(
                texto: "Correo",
                style: false,
              ),
              MyTextFormField(
                texto: "Telefono",
                style: false,
              ),
              MyElevatedButton(fun: () {}, texto: "Guardar")
            ],
          ),
        ));
      },
    );
  }
}
