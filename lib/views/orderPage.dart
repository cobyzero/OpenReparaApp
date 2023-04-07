import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/common.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(status, search.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mynegroprimary(),
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
                          listOrderViewModel.list!.clear();
                          if (search.text.isEmpty) {
                            setState(() {
                              status = 0;
                            });
                            return;
                          }

                          setState(() {
                            status = 1;
                          });
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              /*MyElevatedButton(
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
              )),*/
              MyElevatedButton(
                  fun: () {
                    newOrder();
                  },
                  texto: "New Order"),
              space(h: 20),
              Expanded(
                  child: FutureBuilder(
                future: getData(status, search.text),
                builder: (context, snapshot) {
                  if (listOrderViewModel.list != null) {
                    return ListView.builder(
                      itemCount: listOrderViewModel.list!.length,
                      itemBuilder: (context, index) {
                        return itemRegistro(listOrderViewModel.list![index]);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ))
              /*const MyCredits()*/
            ],
          ),
        ),
      ),
    );
  }

  Container itemRegistro(OrderViewModel clientViewModel) {
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
                  clientViewModel.orderModel.code!,
                  style: TextStyle(color: myprimarycolor()),
                ),
                Row(
                  children: [
                    Text(
                      clientViewModel.orderModel.service!,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    space(w: 10),
                    Text(
                      clientViewModel.orderModel.dispositive!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      clientViewModel.orderModel.nameClient!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    space(w: 10),
                    Text(
                      "[${clientViewModel.orderModel.numberClient!}]",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      clientViewModel.orderModel.marcaDispositive!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    space(w: 10),
                    Text(
                      "[${clientViewModel.orderModel.modelDispositive!}]",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            space(w: 20),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "${clientViewModel.orderModel.price}",
                      style: const TextStyle(color: Colors.green),
                    ),
                    IconButton(
                      icon: Icon(
                        clientViewModel.orderModel.status == 0 ? Icons.check : Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (clientViewModel.orderModel.status == 0) {
                          listOrderViewModel
                              .putStatus(clientViewModel)
                              .whenComplete(() => setState(() {
                                    clientViewModel.orderModel.status = 1;
                                  }));
                        } else if (clientViewModel.orderModel.status == 1) {
                          listOrderViewModel
                              .deleteOrder(clientViewModel)
                              .whenComplete(() => setState(() {
                                    listOrderViewModel.list!.remove(clientViewModel);
                                  }));
                        }
                      },
                    ),
                  ],
                ),
                Text(
                  getStatus(clientViewModel.orderModel.status!),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  getData(int status, String code) async {
    switch (status) {
      case 0:
        await listOrderViewModel.getOrders();
        break;
      case 1:
        await listOrderViewModel.getOrdersForCode(code);
        break;
      default:
    }
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
              backgroundColor: mynegroprimary(),
              title: const Text(
                "New Order",
                style: TextStyle(color: Colors.white),
              ),
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
                    if (page == 1)
                      const Text(
                        "Client data",
                        style: TextStyle(color: Colors.white),
                      ),
                    if (page == 1)
                      MyTextFormField(controller: nameClient, style: false, texto: "Name"),
                    if (page == 1)
                      MyTextFormField(controller: phoneClient, style: false, texto: "Phone"),
                    if (page == 1)
                      MyTextFormField(controller: emailClient, style: false, texto: "Email"),

                    /**
                    * Page 3 [Datos del Celular]
                    */
                    if (page == 2)
                      const Text(
                        "Device data",
                        style: TextStyle(color: Colors.white),
                      ),
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
                    if (page == 3)
                      const Text(
                        "Fault data",
                        style: TextStyle(color: Colors.white),
                      ),
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

  int status = 0;
  var search = TextEditingController();
  ListOrderViewModel listOrderViewModel = ListOrderViewModel();
}
