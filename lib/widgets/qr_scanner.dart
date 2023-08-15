import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:saia_mobile_app/core/api_client.dart';
import 'package:saia_mobile_app/exceptions/custom_exceptions.dart';
import 'package:saia_mobile_app/services/secure_storage.dart';

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
  late Future<List<Receipt>> receiptsList = loadReceiptsList();
  late Future<String> token;
  late Future<String> user;
  late Future<String> local;
  final ApiClient _apiClient = ApiClient();
  final SecureStorageService _secureStorageService = SecureStorageService();

  Future<List<Receipt>> loadReceiptsList() async {
    final userData = await _secureStorageService.loadUserData();
    final docData = await _secureStorageService.loadDocumentAccessData();

    try {
      return receiptsList = _apiClient.consultReceipts(
          userData['token']!.toString(),
          int.parse(userData['local']!.toString()),
          'FAC',
          int.parse(docData['doc']!.toString()));
    } on GeneralException catch (e) {
      throw GeneralException(e.message);
    }
  }

  Future<String> loadToken() async {
    final userData = await _secureStorageService.loadUserData();

    try {
      return userData['token']!.toString();
    } on GeneralException catch (e) {
      throw GeneralException(e.message);
    }
  }

  Future<String> loadUser() async {
    final userData = await _secureStorageService.loadUserData();

    try {
      return userData['username']!.toString();
    } on GeneralException catch (e) {
      throw GeneralException(e.message);
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    controller!.resumeCamera();
    token = loadToken();
    user = loadUser();
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
    final modelCode =
        Battery.getProductModelFromFamilyCode(code.substring(28, 38));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Código QR identificado',
              style: Theme.of(context).textTheme.bodyMedium),
          content: Text(
            'S/N: $code\nFamilia: $modelName \nModelo: $modelCode',
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
              onPressed: () async {
                Navigator.of(context).pop();
                //controller!.resumeCamera();
                // Wait for receiptsList to be loaded
                var productName =
                    Battery.getProductNameFromFamilyCode(code.substring(4, 6));
                var productModel = Battery.getProductModelFromFamilyCode(
                    code.substring(28, 38));
                var completeItemName = "BATERIA $productName $productModel";
                print({completeItemName});
                var r = await receiptsList;
                var t = await token;
                var u = await user;
                var matchingReceipt = r.firstWhere(
                  (receipt) => receipt.itemName == completeItemName,
                );
                print({
                  matchingReceipt.sequence,
                  matchingReceipt.detailId,
                  matchingReceipt.itemName
                });

                _apiClient.assignSerial(t, code, u, matchingReceipt);
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
