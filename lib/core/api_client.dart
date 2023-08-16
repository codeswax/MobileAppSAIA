import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saia_mobile_app/exceptions/custom_exceptions.dart';
import 'package:saia_mobile_app/services/secure_storage.dart';
import '../models/api_data.dart';
import '../models/receipt_data.dart';

class ApiClient {
  final SecureStorageService storageService = SecureStorageService();
  String result = "";
  Future<void> login(LoginData loginData) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
          'http://oasysweb.saia.com.ec/andina/api/seguridad/acceso/login'),
    );

    request.body = json.encode({
      "usuarioId": loginData.user,
      "clave": loginData.pass,
      "empresaId": 1,
      "localId": int.parse(loginData.local),
      "equipoIP": "",
      "equipoNombre": loginData.user,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    switch (response.statusCode) {
      case 200:
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);
        _saveUserData(loginData, responseJson['result']);
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
      String token, ReceiptQueryData receiptQueryData) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://oasysweb.saia.com.ec/andina/api/inventario/reportes/detalleVentasBateriasSinSerie'));
    request.body = json.encode({
      "localId": receiptQueryData.local,
      "documentoTipoId": receiptQueryData.docType,
      "documentoId": receiptQueryData.docId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print({
      receiptQueryData.local,
      receiptQueryData.docType,
      receiptQueryData.docId
    });
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
      String token, ReceiptQueryData receiptQueryData) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://oasysweb.saia.com.ec/andina/api/inventario/reportes/detalleVentasBateriasSinSerie'));
    request.body = json.encode({
      "localId": receiptQueryData.local,
      "documentoTipoId": receiptQueryData.docType,
      "documentoId": receiptQueryData.docId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    switch (response.statusCode) {
      case 200:
        await _saveDocumentData(localString(receiptQueryData.docId));
        break;
      case 204:
        throw InvalidInputException("No se encontraron recibos.");
      default:
        throw GeneralException("Error desconocido.");
    }
  }

  Future<String> assignSerial(
      String token, SerialAssignmentData serialAssignmentData) async {
    String serial = serialAssignmentData.serial;
    String user = serialAssignmentData.user;
    Receipt receipt = serialAssignmentData.receipt;

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://oasysweb.saia.com.ec/andina/api/inventario/documento/asignarSerieArticulo'));
    request.body = json.encode({
      "localId": receipt.localId,
      "documentoTipoId": "FAC",
      "documentoId": receipt.docId,
      "detalleId": receipt.detailId,
      "localDestinoId": receipt.destinationId,
      "secuencia": receipt.sequence,
      "loteId": "",
      "serie": serial,
      "usuarioRegistroId": user,
      "equipoRegistro": user,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    switch (response.statusCode) {
      case 200:
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);
        result = responseJson['message'];
        return result;
      default:
        final responseBody = await response.stream.bytesToString();
        throw GeneralException(responseBody);
    }
  }

  Future<void> _saveUserData(LoginData loginData, String token) async {
    await storageService.saveUserData(
      loginData,
      token,
    );
  }

  Future<void> _saveDocumentData(String doc) async {
    await storageService.saveDocumentAccessData(doc);
  }
}
