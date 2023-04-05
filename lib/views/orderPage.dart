import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/common.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/dataTable.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/textFormField.dart';
import 'package:openrepara_app/models/orderModel.dart';
import 'package:openrepara_app/viewModel/orderViewModel.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              MyAppBar(
                title: "Orders",
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

                          await listOrderViewModel.getOrdersForCode(search.text);

                          setState(() {
                            data = listOrderViewModel.list!;
                          });
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
              ),
              MyElevatedButton(
                  fun: () async {
                    await listOrderViewModel.getOrders();
                    setState(() {
                      data = listOrderViewModel.list!;
                    });
                  },
                  texto: "Load Orders"),
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
                    newOrder();
                  },
                  texto: "New Order"),
              const MyCredits()
            ],
          ),
        ),
      ),
    );
  }

  getRows(List<OrderViewModel> data) {
    List<DataRow> rows = [];
    for (var element in data) {
      rows.add(DataRow(cells: [
        DataCell(Text(element.orderModel.code!)),
        DataCell(Text(element.orderModel.marcaDispositive!)),
        DataCell(Text(element.orderModel.modelDispositive!)),
        DataCell(Text(element.orderModel.imeiDispositive!)),
        DataCell(Text("S/. ${element.orderModel.price}")),
        DataCell(Text(element.orderModel.nameClient!)),
        DataCell(Text(getStatus(element.orderModel.status!))),
        DataCell(Row(
          children: [
            IconButton(
              icon: Icon(element.orderModel.status == 0 ? Icons.check : Icons.delete),
              onPressed: () {
                if (element.orderModel.status == 0) {
                  listOrderViewModel.putStatus(element);
                  setState(() {
                    element.orderModel.status = 1;
                  });
                } else if (element.orderModel.status == 1) {
                  listOrderViewModel.deleteOrder(element);

                  setState(() {
                    data.remove(element);
                  });
                }
              },
            ),
            const IconButton(
              icon: Icon(Icons.picture_as_pdf),
              onPressed: null,
            ),
          ],
        ))
      ]));
    }
    return rows;
  }

  String getStatus(int status) {
    switch (status) {
      case 0:
        return "In Inventory";
      case 1:
        return "Delivered";
      default:
        return "Unknown";
    }
  }

  newOrder() {
    int page = 0;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("New Order"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    if (page == 0)
                      MyTextFormField(
                          controller: typeService, style: false, texto: "Type of service"),
                    if (page == 0)
                      MyTextFormField(
                          controller: typeDevice, style: false, texto: "Type of device"),
                    /**
                   * Page 2 [Datos Cliente]
                   */
                    if (page == 1) const Text("Client data"),
                    if (page == 1)
                      MyTextFormField(controller: nameClient, style: false, texto: "Name"),
                    if (page == 1)
                      MyTextFormField(controller: phoneClient, style: false, texto: "Phone"),
                    if (page == 1)
                      MyTextFormField(controller: emailClient, style: false, texto: "Email"),

                    /**
                    * Page 3 [Datos del Celular]
                    */
                    if (page == 2) const Text("Device data"),
                    if (page == 2)
                      MyTextFormField(controller: marcaDevice, style: false, texto: "Marca"),
                    if (page == 2)
                      MyTextFormField(controller: modelDevide, style: false, texto: "Model"),
                    if (page == 2)
                      MyTextFormField(controller: imeiDevice, style: false, texto: "IMEI"),
                    if (page == 2)
                      MyTextFormField(controller: passwordDevice, style: false, texto: "Password"),
                    if (page == 2)
                      MyTextFormField(controller: pinDevice, style: false, texto: "PIN"),
                    /**
                    * Page 4 [Datos de la falla]
                    */
                    if (page == 3) const Text("Fault data"),
                    if (page == 3)
                      MyTextFormField(controller: error, style: false, texto: "Diagnosis"),
                    if (page == 3)
                      MyTextFormField(controller: observation, style: false, texto: "Obervation"),
                    if (page == 3) MyTextFormField(controller: price, style: false, texto: "Price"),
                    if (page < 3)
                      MyElevatedButton(
                          fun: () {
                            setState(() {
                              page++;
                            });
                          },
                          texto: "Next"),
                    space(h: 10),
                    if (page == 3)
                      MyElevatedButton(
                          fun: () {
                            if (typeService.text.isEmpty ||
                                typeDevice.text.isEmpty ||
                                nameClient.text.isEmpty ||
                                phoneClient.text.isEmpty ||
                                emailClient.text.isEmpty ||
                                marcaDevice.text.isEmpty ||
                                modelDevide.text.isEmpty ||
                                error.text.isEmpty ||
                                observation.text.isEmpty ||
                                price.text.isEmpty) {
                              mensajeError(context, "Missing data");
                              return;
                            }
                            double precioFijo = 0;
                            try {
                              precioFijo = double.parse(price.text);
                            } catch (e) {
                              mensajeError(context, "Invalid price");
                              return;
                            }
                            var ordenesTemp = OrderViewModel(OrderModel(
                                id: 0,
                                code:
                                    "${typeService.text[0]}${typeDevice.text[0]}${nameClient.text[0]}${DateTime.now().day}${DateTime.now().hour}${emailClient.text[0]}",
                                service: typeService.text,
                                dispositive: typeDevice.text,
                                nameClient: nameClient.text,
                                numberClient: phoneClient.text,
                                emailClient: emailClient.text,
                                marcaDispositive: marcaDevice.text,
                                modelDispositive: modelDevide.text,
                                imeiDispositive: imeiDevice.text,
                                passDispositive: passwordDevice.text,
                                pinDispositive: pinDevice.text,
                                failDispositive: error.text,
                                observation: observation.text,
                                price: precioFijo,
                                status: 0,
                                dateOrder: DateTime.now().toIso8601String()));

                            listOrderViewModel
                                .addOrder(ordenesTemp)
                                .whenComplete(() => Navigator.pop(context));
                          },
                          texto: "Confirm"),
                    space(h: 10),
                    if (page > 0)
                      MyElevatedButton(
                          fun: () {
                            setState(() {
                              page--;
                            });
                          },
                          texto: "Back"),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  var typeService = TextEditingController();
  var typeDevice = TextEditingController();
  var nameClient = TextEditingController();
  var phoneClient = TextEditingController();
  var emailClient = TextEditingController();
  var marcaDevice = TextEditingController();
  var modelDevide = TextEditingController();
  var imeiDevice = TextEditingController();
  var passwordDevice = TextEditingController();
  var pinDevice = TextEditingController();
  var error = TextEditingController();
  var observation = TextEditingController();
  var price = TextEditingController();

  List<OrderViewModel> data = [];
  List<String> columns = ["Code", "Marca", "Model", "IMEI", "Price", "Client", "Status", "Actions"];
  var search = TextEditingController();
  ListOrderViewModel listOrderViewModel = ListOrderViewModel();
}
