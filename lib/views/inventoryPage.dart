import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/common.dart'; 
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/textFormField.dart';
import 'package:openrepara_app/viewModel/inventoryViewModel.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(status, _search.text);
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
                title: "Inventary",
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MyTextFormField(
                        controller: _search, texto: "Search", icon: Icons.mobile_friendly),
                    IconButton(
                        onPressed: () async {
                          if (_search.text.isEmpty) {
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
              space(h: 20),
              Expanded(
                  child: FutureBuilder(
                future: getData(status, _search.text),
                builder: (context, snapshot) {
                  if (listInventoryViewModel.list != null) {
                    return ListView.builder(
                      itemCount: listInventoryViewModel.list!.length,
                      itemBuilder: (context, index) {
                        return itemRegistro(listInventoryViewModel.list![index]);
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
      ),
    );
  }

  Container itemRegistro(InventoryViewModel clientViewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
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
                  clientViewModel.inventoryModel.code!,
                  style: TextStyle(color: myprimarycolor()),
                ),
                Row(
                  children: [
                    Text(
                      clientViewModel.inventoryModel.marca!,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    space(w: 10),
                    Text(
                      clientViewModel.inventoryModel.model!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      clientViewModel.inventoryModel.type!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    space(w: 10),
                    Text(
                      "[${clientViewModel.inventoryModel.description!}]",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            space(w: 20),
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                editInventary(clientViewModel);
              },
            ),
          ],
        ),
      ),
    );
  }

  getData(int status, String code) async {
    switch (status) {
      case 0:
        await listInventoryViewModel.getInventory();
        break;
      case 1:
        await listInventoryViewModel.getInventoryForCode(code);
        break;
      default:
    }
  }

  editInventary(InventoryViewModel inventoryViewModel) {
    _marca.text = inventoryViewModel.inventoryModel.marca!;
    _model.text = inventoryViewModel.inventoryModel.model!;
    _imei.text = inventoryViewModel.inventoryModel.imei!;
    _description.text = inventoryViewModel.inventoryModel.description!;
    _type.text = inventoryViewModel.inventoryModel.type!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: mynegroprimary(),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Edit Inventary ${inventoryViewModel.inventoryModel.code}",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  MyTextFormField(
                    controller: _marca,
                    texto: "Marca",
                    style: false,
                  ),
                  MyTextFormField(
                    controller: _model,
                    texto: "Model",
                    style: false,
                  ),
                  MyTextFormField(
                    controller: _imei,
                    texto: "IMEI",
                    style: false,
                  ),
                  MyTextFormField(
                    controller: _description,
                    texto: "Description",
                    style: false,
                  ),
                  MyTextFormField(
                    controller: _type,
                    texto: "Type",
                    style: false,
                  ),
                  MyElevatedButton(
                      fun: () async {
                        inventoryViewModel.inventoryModel.marca = _marca.text;
                        inventoryViewModel.inventoryModel.model = _model.text;
                        inventoryViewModel.inventoryModel.imei = _imei.text;
                        inventoryViewModel.inventoryModel.description = _description.text;
                        inventoryViewModel.inventoryModel.type = _type.text;

                        listInventoryViewModel
                            .putInventory(inventoryViewModel)
                            .whenComplete(() => Navigator.pop(context));

                        setState(() {
                          listInventoryViewModel.list!.clear();
                          status = 0;
                        });
                      },
                      texto: "Save")
                ],
              ),
            ));
      },
    );
  }

  final _search = TextEditingController();
  final _marca = TextEditingController();
  final _model = TextEditingController();
  final _imei = TextEditingController();
  final _description = TextEditingController();
  final _type = TextEditingController();

  int status = 0;
  ListInventoryViewModel listInventoryViewModel = ListInventoryViewModel();
}
