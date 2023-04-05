import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/common.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/dataTable.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/textFormField.dart';
import 'package:openrepara_app/viewModel/inventoryViewModel.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              MyAppBar(
                title: "Inventary",
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MyTextFormField(
                        controller: _search, texto: "Search", icon: Icons.mobile_friendly),
                    IconButton(
                        onPressed: () async {
                          if (_search.text.isEmpty) return;
                          await listInventoryViewModel.getClientForCode(_search.text);

                          setState(() {
                            data = listInventoryViewModel.list!;
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
                    await listInventoryViewModel.getInventary();
                    setState(() {
                      data = listInventoryViewModel.list!;
                    });
                  },
                  texto: "Load"),
              Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:
                        MyDataTable(columns: MyDataTable.getColumns(columns), rows: getRows(data))),
              ),
              MyElevatedButton(
                  fun: () {
                    confirmation();
                  },
                  texto: "Clear Inventary"),
              const MyCredits()
            ],
          ),
        ),
      ),
    );
  }

  getRows(List<InventoryViewModel> data) {
    List<DataRow> rows = [];
    for (var element in data) {
      rows.add(DataRow(cells: [
        DataCell(Text(element.inventoryModel.code!)),
        DataCell(Text(element.inventoryModel.marca!)),
        DataCell(Text(element.inventoryModel.model!)),
        DataCell(Text(element.inventoryModel.imei!)),
        DataCell(Text(element.inventoryModel.description!)),
        DataCell(Text(element.inventoryModel.type!)),
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                editInventary(element);
              },
            ),
          ],
        ))
      ]));
    }
    return rows;
  }

  editInventary(InventoryViewModel inventoryViewModel) {
    _marca.text = inventoryViewModel.inventoryModel.marca!;
    _model.text = inventoryViewModel.inventoryModel.model!;
    _imei.text = inventoryViewModel.inventoryModel.imei!;
    _description.text = inventoryViewModel.inventoryModel.description!;
    _type.text = inventoryViewModel.inventoryModel.type!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Edit Inventary ${inventoryViewModel.inventoryModel.code}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              MyTextFormField(
                controller: _marca,
                texto: "Marca",
                style: false,
              ),
              MyTextFormField(
                controller: _model,
                texto: "Model",
                style: false,
              ),
              MyTextFormField(
                controller: _imei,
                texto: "IMEI",
                style: false,
              ),
              MyTextFormField(
                controller: _description,
                texto: "Description",
                style: false,
              ),
              MyTextFormField(
                controller: _type,
                texto: "Type",
                style: false,
              ),
              MyElevatedButton(
                  fun: () async {
                    inventoryViewModel.inventoryModel.marca = _marca.text;
                    inventoryViewModel.inventoryModel.model = _model.text;
                    inventoryViewModel.inventoryModel.imei = _imei.text;
                    inventoryViewModel.inventoryModel.description = _description.text;
                    inventoryViewModel.inventoryModel.type = _type.text;

                    listInventoryViewModel
                        .putInventary(inventoryViewModel)
                        .whenComplete(() => Navigator.pop(context));

                    setState(() {
                      data.clear();
                    });
                    await listInventoryViewModel.getInventary();
                    setState(() {
                      data = listInventoryViewModel.list!;
                    });
                  },
                  texto: "Save")
            ],
          ),
        ));
      },
    );
  }

  confirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Warning"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Text("The data well be delete."),
                const Text("Continue?"),
                space(h: 20),
                MyElevatedButton(
                    fun: () {
                      setState(() {
                        data.clear();
                      });
                      Navigator.pop(context);
                    },
                    texto: "Confirm"),
                space(h: 10),
                MyElevatedButton(
                    fun: () {
                      Navigator.pop(context);
                    },
                    texto: "Cancel")
              ],
            ),
          ),
        );
      },
    );
  }

  final _search = TextEditingController();
  final _marca = TextEditingController();
  final _model = TextEditingController();
  final _imei = TextEditingController();
  final _description = TextEditingController();
  final _type = TextEditingController();

  List<String> columns = ["Code", "Marca", "Model", "IMEI", "Description", "Type", "Actions"];

  List<InventoryViewModel> data = [];
  ListInventoryViewModel listInventoryViewModel = ListInventoryViewModel();
}
