import 'package:flutter/material.dart';
import 'package:openrepara_app/viewModel/saleViewModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BasePdf {
  pw.Document pdf;
  String numeroDocumento;
  String docProveedor;
  String nombreProveedor;
  String fecha;
  List<String> Columns;
  List<SaleViewModel> data;

  BasePdf(this.pdf, this.numeroDocumento, this.docProveedor, this.nombreProveedor, this.fecha,
      this.Columns, this.data);

  init() {
    return pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(children: [
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
              pw.Text(
                "                   ",
              ),
              pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
                pw.Text("EMPRESA UNIDA",
                    style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text("RUC: 02221", style: const pw.TextStyle(fontSize: 10)),
                pw.Text("Address: av. test", style: const pw.TextStyle(fontSize: 10))
              ]),
              pw.Column(children: [
                pw.Container(
                    alignment: pw.Alignment.center,
                    width: 140,
                    height: 20,
                    child: pw.Text("Document Number",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    decoration: pw.BoxDecoration(
                        color: PdfColors.grey,
                        border: pw.Border.all(width: 1, color: PdfColors.black))),
                pw.Container(
                    alignment: pw.Alignment.center,
                    width: 140,
                    height: 20,
                    child: pw.Text(numeroDocumento,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    decoration:
                        pw.BoxDecoration(border: pw.Border.all(width: 1, color: PdfColors.black)))
              ])
            ]),
            pw.Container(
                margin: const pw.EdgeInsets.only(top: 20, bottom: 5),
                width: double.infinity,
                height: 2,
                color: PdfColors.grey),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
              pw.Row(children: [
                pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                  pw.Text("Support Name:",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
                  pw.Text(docProveedor, style: const pw.TextStyle(fontSize: 10)),
                ]),
                pw.SizedBox(width: 20),
                pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                  pw.Text("Support Email:",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
                  pw.Text(nombreProveedor, style: const pw.TextStyle(fontSize: 10)),
                ])
              ]),
              pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text("Date:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
                pw.Text(fecha, style: const pw.TextStyle(fontSize: 10)),
              ])
            ]),
            pw.SizedBox(height: 30),
            pw.Table(border: pw.TableBorder.all(color: PdfColors.black, width: 1), children: [
              pw.TableRow(children: [
                for (var element in Columns)
                  pw.Container(
                      color: PdfColors.grey,
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        element,
                        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                      )),
              ]),
              for (int e = 0; e < data.length; e++)
                pw.TableRow(children: [
                  pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        data[e].saleModel.code.toString(),
                        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                      )),
                  pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        data[e].saleModel.client!,
                        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                      )),
                  pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        data[e].saleModel.fecha!,
                        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                      )),
                  pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        data[e].saleModel.type!,
                        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                      )),
                  pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        "S/. ${data[e].saleModel.price}",
                        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                      )),
                ]),
            ])
          ]);
        },
      ),
    );
  }

  getColumns() {}
}
