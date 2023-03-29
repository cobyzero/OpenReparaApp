import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/dataTable.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/textFormField.dart';
import 'package:openrepara_app/controllers/clientesController.dart';
import 'package:openrepara_app/models/clientesModel.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  var buscar = TextEditingController();
  var nombre = TextEditingController();
  var correo = TextEditingController();
  var telefono = TextEditingController();

  List<String> columns = ["Codigo", "Nombre", "Correo", "Telefono", "Acciones"];
  List<ClientesModel> data = [];

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
                    MyTextFormField(
                        controller: buscar, texto: "Buscar por Codigo", icon: Icons.person),
                    IconButton(
                        onPressed: () async {
                          if (buscar.text.isEmpty) return;
                          List<ClientesModel> dataTemp =
                              await ClientesController.getClienteForCode(buscar.text);

                          setState(() {
                            data = dataTemp;
                          });
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
              ),
              MyElevatedButton(
                  fun: () async {
                    setState(() {
                      data.clear();
                    });
                    var dataTemp = await ClientesController.getData();

                    setState(() {
                      data = dataTemp;
                    });
                  },
                  texto: "Cargar"),
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
        DataCell(Text(element.code!)),
        DataCell(Text(element.name!)),
        DataCell(Text(element.email!)),
        DataCell(Text(element.number!)),
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
                ClientesController.deleteCliente(element);
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
    nombre.text = clientesModel.name!;
    correo.text = clientesModel.email!;
    telefono.text = clientesModel.number!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Editar Cliente ${clientesModel.code}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              MyTextFormField(
                controller: nombre,
                texto: "Nombre",
                style: false,
              ),
              MyTextFormField(
                controller: correo,
                texto: "Correo",
                style: false,
              ),
              MyTextFormField(
                controller: telefono,
                texto: "Telefono",
                style: false,
              ),
              MyElevatedButton(
                  fun: () async {
                    clientesModel.name = nombre.text;
                    clientesModel.email = correo.text;
                    clientesModel.number = telefono.text;

                    ClientesController.putCliente(clientesModel);

                    nombre.text = "";
                    correo.text = "";
                    telefono.text = "";

                    Navigator.pop(context);
                    setState(() {
                      data.clear();
                    });
                    var dataTemp = await ClientesController.getData();

                    setState(() {
                      data = dataTemp;
                    });
                  },
                  texto: "Guardar")
            ],
          ),
        ));
      },
    );
  }
}
