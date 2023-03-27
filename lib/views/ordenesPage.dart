import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/dataTable.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/textFormField.dart';
import 'package:openrepara_app/models/ordenesModel.dart';

class OrdenesPage extends StatefulWidget {
  const OrdenesPage({super.key});

  @override
  State<OrdenesPage> createState() => _OrdenesPageState();
}

class _OrdenesPageState extends State<OrdenesPage> {
  List<OrdenesModel> data = [
    OrdenesModel(0, "SKDO", "Motorola", "GPE1", "3232132", 800, "Augusto", 0)
  ];
  List<String> columns = [
    "Codigo",
    "Marca",
    "Modelo",
    "IMEI",
    "Precio",
    "Cliente",
    "Estado",
    "Acciones"
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
                title: "Ordenes",
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MyTextFormField(texto: "Buscar por Codigo", icon: Icons.person),
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
                child: MyDataTable(
                  columns: MyDataTable.getColumns(columns),
                  rows: getRows(data),
                ),
              )),
              MyElevatedButton(
                  fun: () {
                    nuevaOrden();
                  },
                  texto: "Nueva Orden"),
              const MyCreditos()
            ],
          ),
        ),
      ),
    );
  }

  getRows(List<OrdenesModel> data) {
    List<DataRow> rows = [];
    for (var element in data) {
      rows.add(DataRow(cells: [
        DataCell(Text(element.codigo)),
        DataCell(Text(element.marca)),
        DataCell(Text(element.modelo)),
        DataCell(Text(element.imei)),
        DataCell(Text("S/. ${element.precio}")),
        DataCell(Text(element.cliente)),
        DataCell(Text(getEstado(element.estado))),
        DataCell(Row(
          children: [
            IconButton(
              icon: Icon(element.estado == 0 ? Icons.check : Icons.delete),
              onPressed: () {
                setState(() {
                  if (element.estado == 0) {
                    data.where((_element) => _element == element).first.estado = 1;
                  } else if (element.estado == 1) {
                    data.remove(element);
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: () {},
            ),
          ],
        ))
      ]));
    }
    return rows;
  }

  String getEstado(int estado) {
    switch (estado) {
      case 0:
        return "En Inventario";
      case 1:
        return "Entregado";
      default:
        return "Desconocido";
    }
  }

  nuevaOrden() {
    int page = 0;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Nueva Orden"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    if (page == 0)
                      MyTextFormField(
                        style: false,
                        texto: "Codigo",
                        readOnly: true,
                      ),
                    if (page == 0) MyTextFormField(style: false, texto: "Tipo de Servicio"),
                    if (page == 0) MyTextFormField(style: false, texto: "Tipo de Dispositivo"),
                    /**
                   * Page 2 [Datos Cliente]
                   */
                    if (page == 1) const Text("Datos del Cliente"),
                    if (page == 1) MyTextFormField(style: false, texto: "Nombre"),
                    if (page == 1) MyTextFormField(style: false, texto: "Telefono"),
                    if (page == 1) MyTextFormField(style: false, texto: "Correo"),

                    /**
                    * Page 3 [Datos del Celular]
                    */
                    if (page == 2) const Text("Datos del Celular"),
                    if (page == 2) MyTextFormField(style: false, texto: "Marca"),
                    if (page == 2) MyTextFormField(style: false, texto: "Modelo"),
                    if (page == 2) MyTextFormField(style: false, texto: "IMEI"),
                    if (page == 2) MyTextFormField(style: false, texto: "Contraseña"),
                    if (page == 2) MyTextFormField(style: false, texto: "PIN"),
                    /**
                    * Page 4 [Datos de la falla]
                    */
                    if (page == 3) const Text("Datos de la falla"),
                    if (page == 3)
                      MyTextFormField(style: false, texto: "Diagnostico / falla / trabajo"),
                    if (page == 3) MyTextFormField(style: false, texto: "Obervacion del equipo"),
                    if (page == 3) MyTextFormField(style: false, texto: "Precio"),
                    if (page < 3)
                      MyElevatedButton(
                          fun: () {
                            setState(() {
                              page++;
                            });
                          },
                          texto: "Siguiente"),
                    if (page == 3)
                      MyElevatedButton(
                          fun: () {
                            Navigator.pop(context);
                          },
                          texto: "Confirmar"),
                    if (page > 0)
                      MyElevatedButton(
                          fun: () {
                            setState(() {
                              page--;
                            });
                          },
                          texto: "Retroceder"),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
