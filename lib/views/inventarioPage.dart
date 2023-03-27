import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/common.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/dataTable.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/textFormField.dart';
import 'package:openrepara_app/models/inventarioModel.dart';

class InventorioPage extends StatefulWidget {
  const InventorioPage({super.key});

  @override
  State<InventorioPage> createState() => _InventorioPageState();
}

class _InventorioPageState extends State<InventorioPage> {
  List<String> columns = [
    "Codigo",
    "Marca",
    "Modelo",
    "Serie",
    "IMEI",
    "Descripcion",
    "Tipo",
    "Acciones"
  ];

  List<InventarioModel> data = [
    InventarioModel(0, "SKEO", "Motorola", "M21", "123123123", "31231323", "NA", "Celular")
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              MyAppBar(
                title: "Inventario",
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MyTextFormField(texto: "Buscar", icon: Icons.mobile_friendly),
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
                    child:
                        MyDataTable(columns: MyDataTable.getColumns(columns), rows: getRows(data))),
              ),
              MyElevatedButton(
                  fun: () {
                    confirmacion();
                  },
                  texto: "Limpiar Inventario"),
              const MyCreditos()
            ],
          ),
        ),
      ),
    );
  }

  getRows(List<InventarioModel> data) {
    List<DataRow> rows = [];
    for (var element in data) {
      rows.add(DataRow(cells: [
        DataCell(Text(element.codigo)),
        DataCell(Text(element.marca)),
        DataCell(Text(element.modelo)),
        DataCell(Text(element.serie)),
        DataCell(Text(element.imei)),
        DataCell(Text(element.descripcion)),
        DataCell(Text(element.tipo)),
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                editInventario(element);
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

  editInventario(InventarioModel clientesModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Editar Inventario ${clientesModel.codigo}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              MyTextFormField(
                texto: "Marca",
                style: false,
              ),
              MyTextFormField(
                texto: "Modelo",
                style: false,
              ),
              MyTextFormField(
                texto: "Serie",
                style: false,
              ),
              MyTextFormField(
                texto: "IMEI",
                style: false,
              ),
              MyTextFormField(
                texto: "Descripcion",
                style: false,
              ),
              MyTextFormField(
                texto: "Tipo",
                style: false,
              ),
              MyElevatedButton(fun: () {}, texto: "Guardar")
            ],
          ),
        ));
      },
    );
  }

  confirmacion() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Advertencia"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Se borraran los datos."),
                const Text("Estas seguro de continuar?"),
                space(h: 20),
                MyElevatedButton(
                    fun: () {
                      setState(() {
                        data.clear();
                      });
                    },
                    texto: "Confirmar"),
                MyElevatedButton(
                    fun: () {
                      Navigator.pop(context);
                    },
                    texto: "Cancelar")
              ],
            ),
          ),
        );
      },
    );
  }
}
