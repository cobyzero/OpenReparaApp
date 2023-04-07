import 'dart:io';

import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/basePdf.dart';
import 'package:openrepara_app/common/common.dart';
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
  ListSaleViewModel listSaleViewModel = ListSaleViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: mynegroprimary(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MyAppBar(title: "Sales"),
            /*MyElevatedButton(
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
            ),*/

            MyElevatedButton(
                fun: () async {
                  if (listSaleViewModel.list!.isEmpty) return;
                  var pdf = pw.Document();
                  var numeroDocumento =
                      "S${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}";
                  BasePdf(
                          pdf,
                          numeroDocumento,
                          LocalData.userViewModel!.usersModel.name!,
                          LocalData.userViewModel!.usersModel.email!,
                          DateTime.now().toString(),
                          ["Code", "Client", "Date", "Type", "Price"],
                          listSaleViewModel.list!)
                      .init();

                  String? picker = await FilePicker.platform.getDirectoryPath();
                  final file = File("$picker/Sale_$numeroDocumento.pdf");
                  await file.writeAsBytes(await pdf.save());
                },
                texto: "Download PDF"),
            // const MyCredits()
            space(h: 20),
            Expanded(
                child: FutureBuilder(
              future: listSaleViewModel.getSale(),
              builder: (context, snapshot) {
                if (listSaleViewModel.list != null) {
                  return ListView.builder(
                    itemCount: listSaleViewModel.list!.length,
                    itemBuilder: (context, index) {
                      return itemRegistro(listSaleViewModel.list![index]);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ))
          ],
        ),
      ),
    ));
  }

  Container itemRegistro(SaleViewModel clientViewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientViewModel.saleModel.code!,
                  style: TextStyle(color: myprimarycolor()),
                ),
                Text(
                  clientViewModel.saleModel.client!,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  clientViewModel.saleModel.type!,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            space(w: 30),
            Column(
              children: [
                Text(
                  "\$${clientViewModel.saleModel.price}",
                  style: const TextStyle(color: Colors.green, fontSize: 12),
                ),
                Text(
                  clientViewModel.saleModel.fecha!,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
