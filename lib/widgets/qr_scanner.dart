import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:saia_mobile_app/exceptions/custom_exceptions.dart';

import '../controllers/qr_controller.dart';
import '../models/battery_data.dart';
import '../models/receipt_data.dart';

class QRScanner extends StatefulWidget {
  final List<Receipt> receipts;
  const QRScanner({
    super.key,
    required this.receipts,
  });

  @override
  State<QRScanner> createState() => QRScannerState();
}

class QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  List<Battery> batteries = [];

  @override
  void reassemble() {
    super.reassemble();
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 240,
      child: ClipRect(
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.transparent,
            borderRadius: 40,
            borderLength: 40,
            borderWidth: 10,
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        _validateQR(result!.code!);
        controller.pauseCamera();
      });
    });
  }

  void _showResultDialog(String code) {
    final modelName =
        Battery.getProductNameFromFamilyCode(code.substring(4, 6));
    final modelCode = code.substring(28, 38);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Código QR identificado',
              style: Theme.of(context).textTheme.bodyMedium),
          content: Text(
            'S/N: $code\nFamilia: $modelName \nModel0: $modelCode',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
                controller!.resumeCamera();
              },
              child: Text(
                'Cancelar',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.of(context).pop();
                controller!.resumeCamera();
              },
              child: Text('Registrar',
                  style: Theme.of(context).textTheme.labelSmall),
            ),
          ],
        );
      },
    );
  }

  void _validateQR(String code) {
    try {
      checkQR(code);
      _showResultDialog(code);
    } on InvalidQRException catch (e) {
      _showExceptionDialog(e.message);
    } on GeneralException catch (e) {
      _showExceptionDialog(e.message);
    }
  }

  void _showExceptionDialog(String content) {
    if (!context.mounted) return;
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'ERROR',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              content: Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    Future.delayed(const Duration(milliseconds: 300), () {
                      controller!.resumeCamera();
                    });
                  },
                  child: Text(
                    'OK',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
