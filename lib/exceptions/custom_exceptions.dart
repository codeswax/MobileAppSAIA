import '../models/api_data.dart';
import '../utils/product_constants.dart';

abstract class AppException implements Exception {
  final String message;

  AppException(this.message);
}

class InvalidInputException extends AppException {
  InvalidInputException(String message) : super(message);
}

class InvalidCredentialsException extends AppException {
  InvalidCredentialsException(String message) : super(message);
}

class InvalidQRException extends AppException {
  InvalidQRException(String message) : super(message);
}

class GeneralException extends AppException {
  GeneralException(String message) : super(message);
}

class ValidationService {
  void checkCredentials(LoginData loginData) {
    String user = loginData.user;
    String pass = loginData.pass;
    String local = loginData.local;
    if (user.isEmpty || pass.isEmpty || local.isEmpty) {
      throw InvalidInputException("Los campos no pueden estar vacíos.");
    } else if (double.tryParse(local) == null) {
      throw InvalidInputException("Local no válido. Debe ser un número.");
    }
  }

  void checkReceiptData(String docId) {
    if (docId.isEmpty) {
      throw InvalidInputException("El campo no puede estar vacío.");
    } else if (double.tryParse(docId) == null) {
      throw InvalidInputException("Documento no válido. Debe ser un número.");
    }
  }

  void checkQR(String code) {
    if (code.isEmpty) throw GeneralException("No se pudo obtener el código.");

    final fabricationMonth = code.substring(0, 2);
    final familyCode = code.substring(4, 6);
    final model = code.substring(28, 38);

    if (code.length != 59 ||
        !validMonths.contains(fabricationMonth) ||
        !validMACs.contains(familyCode) ||
        !validModels.contains(model)) {
      throw InvalidQRException(
          "El código escaneado no corresponde a un número de serie");
    }
  }
 String checkQRTest(String code) {
  if (code.isEmpty) {
    return "No se pudo obtener el código.";
  }

  final fabricationMonth = code.substring(0, 2);
  final familyCode = code.substring(4, 6);
  final model = code.substring(28, 38);

  if (code.length != 59 ||
      !validMonths.contains(fabricationMonth) ||
      !validMACs.contains(familyCode) ||
      !validModels.contains(model)) {
    return "El código escaneado no corresponde a un número de serie.";
  }

  return "El código es válido."; // Cambia esto al mensaje que desees
}

}

