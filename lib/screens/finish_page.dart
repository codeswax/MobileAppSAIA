import 'package:flutter/material.dart';

class FinishPage extends StatelessWidget {
  const FinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xff485A7E)),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xff485A7E),
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            margin: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Center(
                child: Container(
              width: 330,
              height: 330,
              decoration: const BoxDecoration(color: Color(0xffFFFFFF)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xff5BE01D),
                      size: 100.0,
                    ),
                    const Text(
                      "Documento generado correctamente.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Lato',
                        color: Color(0xff000000),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(25.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xffF6AD3A),
                            padding: const EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            minimumSize: const Size(150, 50)),
                        onPressed: () {},
                        child: const Text("Registrar otra factura",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Lato',
                            )),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.transparent,
                          padding: const EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          minimumSize: const Size(150, 50)),
                      onPressed: () {},
                      child: const Text("Salir",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Lato',
                          )),
                    ),
                  ]),
            )),
          ),
        ),
      ),
    );
  }
}
