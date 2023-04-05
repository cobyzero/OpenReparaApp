import 'dart:math';

import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/dataTable.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/textFormField.dart';
import 'package:openrepara_app/viewModel/clientViewModel.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  var search = TextEditingController();
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();

  List<String> columns = ["Code", "Name", "Email", "Phone", "Actions"];
  List<ClientViewModel> data = [];
  ListClientViewModel listClientesViewModel = ListClientViewModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              MyAppBar(
                title: "Clients",
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MyTextFormField(
                        controller: search, texto: "Search by code", icon: Icons.person),
                    IconButton(
                        onPressed: () async {
                          if (search.text.isEmpty) return;

                          await listClientesViewModel.getClienteForCode(search.text);

                          setState(() {
                            data = listClientesViewModel.clientViewModel!;
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

                    await listClientesViewModel.getData().whenComplete(() => setState(() {
                          data = listClientesViewModel.clientViewModel!;
                        }));
                  },
                  texto: "Load"),
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: MyDataTable(columns: MyDataTable.getColumns(columns), rows: getRows(data)),
              )),
              const MyCredits()
            ],
          ),
        ),
      ),
    );
  }

  getRows(List<ClientViewModel> data) {
    List<DataRow> rows = [];
    for (var element in data) {
      rows.add(DataRow(cells: [
        DataCell(Text(element.clientModel.code!)),
        DataCell(Text(element.clientModel.name!)),
        DataCell(Text(element.clientModel.email!)),
        DataCell(Text(element.clientModel.number!)),
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                editClient(element);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                listClientesViewModel.deleteCliente(element);
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

  editClient(ClientViewModel clientViewModel) {
    name.text = clientViewModel.clientModel.name!;
    email.text = clientViewModel.clientModel.email!;
    phone.text = clientViewModel.clientModel.number!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Editar Cliente ${clientViewModel.clientModel.code}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              MyTextFormField(
                controller: name,
                texto: "Nombre",
                style: false,
              ),
              MyTextFormField(
                controller: email,
                texto: "Correo",
                style: false,
              ),
              MyTextFormField(
                controller: phone,
                texto: "Telefono",
                style: false,
              ),
              MyElevatedButton(
                  fun: () async {
                    clientViewModel.clientModel.name = name.text;
                    clientViewModel.clientModel.email = email.text;
                    clientViewModel.clientModel.number = phone.text;

                    listClientesViewModel.putCliente(clientViewModel);

                    name.text = "";
                    email.text = "";
                    phone.text = "";

                    Navigator.pop(context);
                    setState(() {
                      data.clear();
                    });
                    await listClientesViewModel.getData();

                    setState(() {
                      data = listClientesViewModel.clientViewModel!;
                    });
                  },
                  texto: "Save")
            ],
          ),
        ));
      },
    );
  }
}
