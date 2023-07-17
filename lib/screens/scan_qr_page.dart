import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/qr_scanner.dart';

class ScanQrPage extends StatefulWidget {
  ScanQrPage({Key? key}) : super(key: key);

  @override
  _ScanQrPageState createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  bool isPanelExpanded = false;
  late PanelController _panelController;

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xff5C5E5F)),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: const Color(0xff5C5E5F),
            title: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Text(
                  isPanelExpanded ? 'Revisa' : 'Escanea',
                );
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          body: SlidingUpPanel(
            controller: _panelController,
            minHeight: 200,
            maxHeight: MediaQuery.of(context).size.height,
            panel: Container(
              decoration: const BoxDecoration(color: Color(0xff485A7E)),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/icons/line.svg',
                    width: 60,
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        Container(
                          width: 310,
                          height: 480,
                          decoration:
                              const BoxDecoration(color: Color(0xffD9D9D9)),
                          child: const SingleChildScrollView(
                            scrollDirection: Axis.vertical,
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
                            onPressed: () {
                              Navigator.pushNamed(context, '/preview');
                            },
                            child: const Text(
                              "Confirmar y terminar",
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
                              _panelController.animatePanelToPosition(
                                0.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: const Text(
                              "Seguir registrando",
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
                ],
              ),
            ),
            collapsed: Container(
              decoration: const BoxDecoration(color: Color(0xff485A7E)),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/icons/line.svg',
                    width: 60,
                    height: 10,
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "¡Articulo reconocido!",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "Bateria código X0000000",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Lato',
                              color: Color(0xffFFFFFF),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Icon(
                            Icons.live_help,
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Articulos registrados: 0",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Lato',
                              color: Color(0xffFFFFFF),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xffF6AD3A),
                              padding: const EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Registrar",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(flex: 1),
                Container(
                  margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Align(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 20,
                      children: [
                        const QRScanner(),
                        Row(
                          children: const [
                            Icon(
                              Icons.live_help,
                              color: Colors.white,
                              size: 40.0,
                            ),
                            SizedBox(width: 30),
                            Expanded(
                              child: Text(
                                "Mantén fijo el celular para hasta que se capture correctamente.",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Lato',
                                  color: Color(0xffFFFFFF),
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
            onPanelSlide: (double pos) {
              setState(() {
                isPanelExpanded =
                    pos > 0.2; // Ajusta el valor según tus necesidades
              });
            },
          ),
        ),
      ),
    );
  }
}
