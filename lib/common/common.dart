import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

space({double w = 0, double h = 0}) {
  return SizedBox(
    width: w,
    height: h,
  );
}

cargando(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Cargando.."),
              space(h: 20),
              const SizedBox(width: 50, height: 50, child: CircularProgressIndicator.adaptive())
            ],
          ),
        ),
      );
    },
  );
}

mensajeError(BuildContext context, String texto) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(content: Text(texto));
    },
  );
}

myprimarycolor() {
  return const Color(0xff5e5bf4);
}

mynegroprimary() {
  return const Color(0xff171717);
}
