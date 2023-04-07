import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/common.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/textFormField.dart';
import 'package:openrepara_app/viewModel/clientViewModel.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  var search = TextEditingController();
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();

  List<String> columns = ["Code", "Name", "Email", "Phone", "Actions"];

  ListClientViewModel listClientesViewModel = ListClientViewModel();

  int status = 0;

  getData(int status, String code) async {
    switch (status) {
      case 0:
        await listClientesViewModel.getData();
        break;
      case 1:
        await listClientesViewModel.getClienteForCode(code);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mynegroprimary(),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyAppBar(
                title: "Clients",
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MyTextFormField(
                        controller: search, texto: "Search by code", icon: Icons.person),
                    IconButton(
                        onPressed: () async {
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
                    setState(() {
                      data.clear();
                    });

                    await listClientesViewModel.getData().whenComplete(() => setState(() {
                          data = listClientesViewModel.clientViewModel!;
                        }));
                  },
                  texto: "Load"),*/
              space(h: 20),
              Expanded(
                  child: FutureBuilder(
                future: getData(status, search.text),
                builder: (context, snapshot) {
                  if (listClientesViewModel.clientViewModel != null) {
                    return ListView.builder(
                      itemCount: listClientesViewModel.clientViewModel!.length,
                      itemBuilder: (context, index) {
                        return itemRegistro(listClientesViewModel.clientViewModel![index]);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ))
              /*Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: MyDataTable(columns: MyDataTable.getColumns(columns), rows: getRows(data)),
              )),
              const MyCredits()*/
            ],
          ),
        ),
      ),
    );
  }

  Container itemRegistro(ClientViewModel clientViewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                clientViewModel.clientModel.code!,
                style: TextStyle(color: myprimarycolor()),
              ),
              Text(
                clientViewModel.clientModel.name!,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                clientViewModel.clientModel.email!,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                clientViewModel.clientModel.number!,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  editClient(clientViewModel);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  listClientesViewModel
                      .deleteCliente(clientViewModel)
                      .whenComplete(() => setState(() {
                            listClientesViewModel.clientViewModel!.clear();
                            listClientesViewModel.getData();
                          }));
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  editClient(ClientViewModel clientViewModel) {
    name.text = clientViewModel.clientModel.name!;
    email.text = clientViewModel.clientModel.email!;
    phone.text = clientViewModel.clientModel.number!;
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
                    "Editar Cliente ${clientViewModel.clientModel.code}",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  MyTextFormField(
                    controller: name,
                    texto: "Nombre",
                    style: false,
                  ),
                  MyTextFormField(
                    controller: email,
                    texto: "Correo",
                    style: false,
                  ),
                  MyTextFormField(
                    controller: phone,
                    texto: "Telefono",
                    style: false,
                  ),
                  MyElevatedButton(
                      fun: () async {
                        clientViewModel.clientModel.name = name.text;
                        clientViewModel.clientModel.email = email.text;
                        clientViewModel.clientModel.number = phone.text;

                        listClientesViewModel.putCliente(clientViewModel);

                        name.text = "";
                        email.text = "";
                        phone.text = "";

                        Navigator.pop(context);
                        setState(() {
                          listClientesViewModel.clientViewModel!.clear();
                        });
                        await listClientesViewModel.getData();

                        setState(() {});
                      },
                      texto: "Save")
                ],
              ),
            ));
      },
    );
  }
}
