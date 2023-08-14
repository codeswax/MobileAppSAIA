import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saia_mobile_app/exceptions/custom_exceptions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../core/api_client.dart';
import '../models/receipt_data.dart';
import '../services/secure_storage.dart';

class AvailableReceiptsContainer extends StatefulWidget {
  final List<Receipt> receipts;
  const AvailableReceiptsContainer({
    super.key,
    required this.receipts,
  });

  //final PanelController _panelController;

  @override
  State<AvailableReceiptsContainer> createState() =>
      _AvailableReceiptsContainerState();
}

class _AvailableReceiptsContainerState
    extends State<AvailableReceiptsContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 70, 71, 72),
          title: Text(
            'Revisa',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Color(0xff485A7E)),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                      child: Center(
                        child: Text('Recibos disponibles',
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ),
                    Container(
                        width: 320,
                        height: 580,
                        decoration:
                            const BoxDecoration(color: Color(0xffD9D9D9)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.receipts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 310,
                              height: 110,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ID: ${widget.receipts[index].detailId.toString()}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    'Secuencia: ${widget.receipts[index].sequence.toString()}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    'Descripción: ${widget.receipts[index].itemName.toString()}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            );
                          },
                        )),
                    const SizedBox(height: 20),
                    Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(25.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffF6AD3A),
                          padding: const EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: () {
                          //Navigator.pushNamed(context, '/preview');
                        },
                        child: Text("Confirmar y terminar",
                            style: Theme.of(context).textTheme.labelSmall),
                      ),
                    ),
                    //const SizedBox(height: 10),
                    /*
                    Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(25.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: () {
                          widget._panelController.animatePanelToPosition(
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
                          ),
                        ),
                      ),
                    ),
                    */
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
