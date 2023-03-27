import 'package:flutter/material.dart';
import 'package:openrepara_app/views/clientesPage.dart';
import 'package:openrepara_app/views/homePage.dart';
import 'package:openrepara_app/views/inventarioPage.dart';
import 'package:openrepara_app/views/loginPage.dart';
import 'package:openrepara_app/views/ordenesPage.dart';
import 'package:openrepara_app/views/ventasPage.dart';

Map<String, WidgetBuilder> routesApp() {
  return {
    "login": (context) => const LoginPage(),
    "home": (context) => const HomePage(),
    "clientes": (context) => const ClientesPage(),
    "inventorio": (context) => const InventorioPage(),
    "ordenes": (context) => const OrdenesPage(),
    "ventas": (context) => const VentasPage()
  };
}
