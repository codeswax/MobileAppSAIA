import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xffF6AD3A)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Image(
                    image: AssetImage('assets/images/icons/logo.jpg'),
                    fit: BoxFit.cover,
                  ),
                  const Text("REGISTRO DE INVENTARIO",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'Lato',
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w800)),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xff4658A7),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      minimumSize: const Size.fromHeight(75),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/enterReceipt');
                    },
                    child: const Text("Iniciar",
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Lato',
                        )),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
