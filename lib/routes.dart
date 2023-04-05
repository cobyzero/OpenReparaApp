import 'package:flutter/material.dart';
import 'package:openrepara_app/views/clientPage.dart';
import 'package:openrepara_app/views/homePage.dart';
import 'package:openrepara_app/views/inventoryPage.dart';
import 'package:openrepara_app/views/loginPage.dart';
import 'package:openrepara_app/views/orderPage.dart';
import 'package:openrepara_app/views/salePage.dart';

Map<String, WidgetBuilder> routesApp() {
  return {
    "login": (context) => const LoginPage(),
    "home": (context) => const HomePage(),
    "clientes": (context) => const ClientesPage(),
    "inventorio": (context) => const InventoryPage(),
    "ordenes": (context) => const OrderPage(),
    "ventas": (context) => const SalePage()
  };
}
