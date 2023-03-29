import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/common.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/dataTable.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/textFormField.dart';
import 'package:openrepara_app/controllers/inventarioController.dart';
import 'package:openrepara_app/models/inventarioModel.dart';

class InventorioPage extends StatefulWidget {
  const InventorioPage({super.key});

  @override
  State<InventorioPage> createState() => _InventorioPageState();
}

class _InventorioPageState extends State<InventorioPage> {
  var buscar = TextEditingController();
  var marca = TextEditingController();
  var modelo = TextEditingController();
  var serie = TextEditingController();
  var imei = TextEditingController();
  var descripcion = TextEditingController();
  var tipo = TextEditingController();

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

  List<InventarioModel> data = [];

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
                    MyTextFormField(
                        controller: buscar, texto: "Buscar", icon: Icons.mobile_friendly),
                    IconButton(
                        onPressed: () async {
                          if (buscar.text.isEmpty) return;
                          var dataTemp = await InventarioController.getClienteForCode(buscar.text);

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
                    var dataTemp = await InventarioController.getInventario();
                    setState(() {
                      data = dataTemp;
                    });
                  },
                  texto: "Cargar Inventario"),
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
        DataCell(Text(element.code!)),
        DataCell(Text(element.marca!)),
        DataCell(Text(element.model!)),
        DataCell(Text(element.serial!)),
        DataCell(Text(element.imei!)),
        DataCell(Text(element.description!)),
        DataCell(Text(element.type!)),
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
                "Editar Inventario ${clientesModel.code}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              MyTextFormField(
                controller: marca,
                texto: "Marca",
                style: false,
              ),
              MyTextFormField(
                controller: modelo,
                texto: "Modelo",
                style: false,
              ),
              MyTextFormField(
                controller: serie,
                texto: "Serie",
                style: false,
              ),
              MyTextFormField(
                controller: imei,
                texto: "IMEI",
                style: false,
              ),
              MyTextFormField(
                controller: descripcion,
                texto: "Descripcion",
                style: false,
              ),
              MyTextFormField(
                controller: tipo,
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
