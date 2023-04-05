import 'dart:io';

import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/basePdf.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/dataTable.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/localData.dart';
import 'package:openrepara_app/viewModel/saleViewModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  List<String> columns = ["Code", "Client", "Date", "Type", "Price"];
  List<SaleViewModel> data = [];
  ListSaleViewModel listSaleViewModel = ListSaleViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MyAppBar(title: "Ventas"),
            MyElevatedButton(
                fun: () async {
                  setState(() {
                    data.clear();
                  });

                  await listSaleViewModel.getSale();

                  setState(() {
                    data = listSaleViewModel.list!;
                  });
                },
                texto: "Load Sales"),
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:
                      MyDataTable(columns: MyDataTable.getColumns(columns), rows: getRows(data))),
            ),
            MyElevatedButton(
                fun: () async {
                  if (data.isEmpty) return;
                  var pdf = pw.Document();
                  var numeroDocumento =
                      "S${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}";
                  BasePdf(
                          pdf,
                          numeroDocumento,
                          LocalData.userViewModel!.usersModel.name!,
                          LocalData.userViewModel!.usersModel.email!,
                          DateTime.now().toString(),
                          columns,
                          data)
                      .init();

                  String? picker = await FilePicker.platform.getDirectoryPath();
                  final file = File("$picker/Entrada_$numeroDocumento.pdf");
                  await file.writeAsBytes(await pdf.save());
                },
                texto: "Descargar PDF"),
            const MyCredits()
          ],
        ),
      ),
    ));
  }

  getRows(List<SaleViewModel> data) {
    List<DataRow> rows = [];
    for (var element in data) {
      rows.add(DataRow(cells: [
        DataCell(Text(element.saleModel.code!)),
        DataCell(Text(element.saleModel.client!)),
        DataCell(Text(element.saleModel.fecha!)),
        DataCell(Text(element.saleModel.type!)),
        DataCell(Text("S/. ${element.saleModel.price}")),
      ]));
    }
    return rows;
  }
}
