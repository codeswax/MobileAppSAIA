import 'package:flutter/material.dart';
import 'package:saia_mobile_app/widgets/receipt_data_field.dart';

class EnterReceiptPage extends StatelessWidget {
  const EnterReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
              child: Text("¡Bienvenido!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge),
            ),
            Text("Ingresa el número de factura para empezar a registrar:",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            const ReceiptDataWidget(),
          ]),
        ),
      ),
    );
  }
}
