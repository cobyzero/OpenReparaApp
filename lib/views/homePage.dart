import 'package:flutter/material.dart';
import 'package:openrepara_app/common/appbar.dart';
import 'package:openrepara_app/common/common.dart';
import 'package:openrepara_app/common/localData.dart';
import 'package:openrepara_app/viewModel/saleViewModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ListSaleViewModel listSaleViewModel = ListSaleViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: mynegroprimary(),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            MyAppBar(
              home: true,
              title: "OpenRepair",
            ),
            space(h: 20),
            Text(
              LocalData.userViewModel!.usersModel.name!,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              LocalData.userViewModel!.usersModel.email!,
              style: const TextStyle(color: Colors.grey),
            ),
            space(h: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                containerSeccion("Clients", Colors.green, "assets/usuario.png", () {
                  Navigator.pushNamed(context, "clientes");
                }),
                containerSeccion("Inventory", Colors.blue, "assets/caja-alt.png", () {
                  Navigator.pushNamed(context, "inventorio");
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                containerSeccion("Orders", Colors.red, "assets/documento.png", () {
                  Navigator.pushNamed(context, "ordenes").then((value) => setState(() {}));
                }),
                containerSeccion("Sales", Colors.amber, "assets/dolar.png", () {
                  Navigator.pushNamed(context, "ventas").then((value) => setState(() {}));
                }),
              ],
            ),
            space(h: 30),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.35,
                decoration: const BoxDecoration(
                    color: Color(0xff1E1E1E),
                    boxShadow: [
                      BoxShadow(color: Colors.black, offset: Offset(2, 3), blurRadius: 8)
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Last Sales",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "ventas");
                            },
                            child: const Text(
                              "View all",
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ))
                      ],
                    ),
                    Expanded(
                        child: FutureBuilder(
                      future: listSaleViewModel.getSale(),
                      builder: (context, snapshot) {
                        if (listSaleViewModel.list != null) {
                          return ListView.builder(
                            itemCount: listSaleViewModel.list!.length < 5
                                ? listSaleViewModel.list!.length
                                : 5,
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
            )
          ],
        ),
      ),
    ));
  }

  Container itemRegistro(SaleViewModel saleViewModel) {
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
                  saleViewModel.saleModel.client!,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  saleViewModel.saleModel.fecha!,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            space(w: 20),
            Text(
              "+ \$${saleViewModel.saleModel.price}",
              style: const TextStyle(color: Colors.green),
            )
          ],
        ),
      ),
    );
  }

  containerSeccion(String title, Color color, String image, Function() fun) {
    return InkWell(
      highlightColor: Colors.black,
      onTap: fun,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.35 + 20,
            height: MediaQuery.of(context).size.width * 0.35,
            decoration: BoxDecoration(
                color: const Color(0xff1E1E1E),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(2, 3), blurRadius: 8)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), color: color.withOpacity(0.3)),
                  child: Image.asset(
                    image,
                    width: 20,
                    color: color,
                  ),
                ),
                space(h: 20),
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
