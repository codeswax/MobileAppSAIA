import 'package:flutter/material.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key}) : super(key: key);

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Container(
                    width: 310,
                    height: 480,
                    decoration: const BoxDecoration(color: Color(0xffD9D9D9)),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        "GeeksForGeeks is a good platform to learn programming."
                        " It is an educational website.SMADNAJDNAJDBAJDBAHDGAHDBASHDGAHDBGAYUDGAJKDSBNAHDFADHBAHDGFAYDGAJKDSBAYTDAYUHDBYUDFAGHBJGFTDVGHJADFTA",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          letterSpacing: 3,
                          wordSpacing: 3,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(25.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xffF6AD3A),
                        padding: const EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        minimumSize: const Size(150, 50),
                      ),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/main');
                      },
                      child: const Text(
                        "Guardar PDF",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(25.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        minimumSize: const Size(150, 50),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Guardar",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
