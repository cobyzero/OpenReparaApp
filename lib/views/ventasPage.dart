import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/dataTable.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/models/ventasModel.dart';

class VentasPage extends StatefulWidget {
  const VentasPage({super.key});

  @override
  State<VentasPage> createState() => _VentasPageState();
}

class _VentasPageState extends State<VentasPage> {
  List<String> columns = ["Codigo", "Cliente", "Fecha", "Tipo", "Precio"];
  List<VentasModel> data = [VentasModel(0, "SKD", "Augusto", "12/02/2023", "Reparacion", 800)];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MyAppBar(title: "Ventas"),
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:
                      MyDataTable(columns: MyDataTable.getColumns(columns), rows: getRows(data))),
            ),
            MyElevatedButton(fun: () {}, texto: "Descargar PDF"),
            const MyCreditos()
          ],
        ),
      ),
    ));
  }

  getRows(List<VentasModel> data) {
    List<DataRow> rows = [];
    for (var element in data) {
      rows.add(DataRow(cells: [
        DataCell(Text(element.codigo)),
        DataCell(Text(element.cliente)),
        DataCell(Text(element.fecha)),
        DataCell(Text(element.tipo)),
        DataCell(Text("S/. ${element.precio}")),
      ]));
    }
    return rows;
  }
}
