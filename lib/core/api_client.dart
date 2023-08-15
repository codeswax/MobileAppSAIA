import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saia_mobile_app/exceptions/custom_exceptions.dart';
import 'package:saia_mobile_app/services/secure_storage.dart';

import '../models/receipt_data.dart';
import '../models/battery_data.dart';

class ApiClient {
  final SecureStorageService storageService = SecureStorageService();

  Future<void> login(String user, String pass, int local) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
          'http://oasysweb.saia.com.ec/andina/api/seguridad/acceso/login'),
    );
    request.body = json.encode({
      "usuarioId": user,
      "clave": pass,
      "empresaId": 1,
      "localId": local,
      "equipoIP": "",
      "equipoNombre": user,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    switch (response.statusCode) {
      case 200:
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);
        _saveUserData(user, local.toString(), responseJson['result']);
        break;
      case 400:
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);
        String message = responseJson['message'];
        throw InvalidCredentialsException(message);
      default:
        throw GeneralException("Error inesperado.");
    }
  }

  Future<List<Receipt>> consultReceipts(
      String token, num local, String docType, num docId) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://oasysweb.saia.com.ec/andina/api/inventario/reportes/detalleVentasBateriasSinSerie'));
    request.body = json.encode(
        {"localId": local, "documentoTipoId": docType, "documentoId": docId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    switch (response.statusCode) {
      case 200:
        List<Receipt> receipts = [];
        for (var e in jsonDecode(await response.stream.bytesToString())) {
          receipts.add(Receipt.fromJson(e));
        }
        return receipts;
      case 204:
        throw InvalidInputException("No se encontraron recibos.");
      default:
        throw GeneralException("Error desconocido.");
    }
  }

  Future<void> consultAvailabilityOfReceipts(
      String token, num local, String docType, num docId) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://oasysweb.saia.com.ec/andina/api/inventario/reportes/detalleVentasBateriasSinSerie'));
    request.body = json.encode(
        {"localId": local, "documentoTipoId": docType, "documentoId": docId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    switch (response.statusCode) {
      case 200:
        await _saveDocumentData(docId.toString());
        break;
      case 204:
        throw InvalidInputException("No se encontraron recibos.");
      default:
        throw GeneralException("Error desconocido.");
    }
  }

  Future<void> assignSerial(
      String token, String serial, String user, Receipt receipt) async {
    //debes de reducir la cantidad de parametros, es decir crea algun servicio que te permita almacenar al usuario, cosa que de esa manera no tengas que enviarlo, de la misma manera con el token
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://oasysweb.saia.com.ec/andina/api/inventario/documento/asignarSerieArticulo'));
    request.body = json.encode({
      "localId": receipt.localId, // esto estaba antes "localId": local,
      "documentoTipoId": "FAC",
      "documentoId": receipt.docId, // esto estaba antes "documentoId": docId,
      "detalleId": receipt.detailId,
      "localDestinoId":
          receipt.destinationId, // esto estaba antes "localDestinoId": local,
      "secuencia": receipt.sequence,
      "loteId": "",
      "serie": serial,
      "usuarioRegistroId": user,
      "equipoRegistro": user,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> _saveUserData(String user, String local, String token) async {
    await storageService.saveUserData(
      user,
      local,
      token,
    );
  }

  Future<void> _saveDocumentData(String doc) async {
    await storageService.saveDocumentAccessData(doc);
  }

  Future<void> insertSerialToReceipt(
    String productCode,
    String receiptCode,
    String token,
    String user,
    int local,
    String docType,
  ) async {
    var receiptsWithoutSerial =
        await consultReceipts(token, local, docType, int.parse(receiptCode));
    var productName =
        Battery.getProductNameFromFamilyCode(productCode.substring(4, 6));
    var productModel =
        Battery.getProductModelFromFamilyCode(productCode.substring(28, 38));
    print({productName, productModel});
    var completeItemName = "BATERIA $productName $productModel";
    var matchingReceipt = receiptsWithoutSerial.firstWhere(
      (receipt) => receipt.itemName == completeItemName,
    );
  }
}
