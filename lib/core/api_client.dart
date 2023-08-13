import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saia_mobile_app/exceptions/custom_exceptions.dart';
import 'package:saia_mobile_app/services/secure_storage.dart';

import '../models/receipt_data.dart';

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
    try {
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
          throw InvalidInputException("El valor ingresado no es correcto.");
        default:
          throw GeneralException("Error desconocido.");
      }
    } catch (e) {
      throw Error();
    }
  }

  Future<void> _saveUserData(String user, String local, String token) async {
    await storageService.saveUserData(
      user,
      local,
      token,
    );
  }
}
