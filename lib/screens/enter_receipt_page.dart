import 'package:flutter/material.dart';

class EnterReceiptPage extends StatelessWidget {
  const EnterReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xffFFFFFF)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: const EdgeInsets.only(left: 25.0, right: 25.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                child: Text("¡Bienvenido!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 48.0,
                        fontFamily: 'Lato',
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 5)),
              ),
              const Text(
                  "Ingresa el número de factura para empezar a registrar:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Lato',
                      color: Color(0xff000000),
                      fontWeight: FontWeight.normal)),
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                child: SizedBox(
                    width: 275.0,
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    )),
              ),
              Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(25.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: const Color(0xff4658A7),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      minimumSize: const Size(150, 50)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/scanQR');
                  },
                  child: const Text("Ingresar",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Lato',
                      )),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
