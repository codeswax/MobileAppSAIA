class InvalidInputException implements Exception {
  final String message;

  InvalidInputException(this.message);
}

class InvalidCredentialsException implements Exception {
  final String message;

  InvalidCredentialsException(this.message);
}

class GeneralException implements Exception {
  final String message;

  GeneralException(this.message);
}

void checkCredentials(String user, String pass, String local) {
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
