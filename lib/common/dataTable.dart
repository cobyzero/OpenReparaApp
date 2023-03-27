import 'package:flutter/material.dart';

class MyDataTable extends StatelessWidget {
  MyDataTable({super.key, required this.columns, required this.rows});
  List<DataColumn> columns;
  List<DataRow> rows;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: DataTable(columnSpacing: 14, columns: columns, rows: rows));
  }

  static getListColumns(List<String> data) {
    List<DataColumn> columns = [];
    for (var element in data) {
      columns.add(DataColumn(label: Text(element)));
    }
    return columns;
  }

  static getColumns(List<String> columnsGet) {
    List<DataColumn> columnsTemp = [];

    for (var element in columnsGet) {
      columnsTemp.add(DataColumn(label: Text(element)));
    }
    return columnsTemp;
  }
}
