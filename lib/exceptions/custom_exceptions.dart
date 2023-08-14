class InvalidInputException implements Exception {
  final String message;

  InvalidInputException(this.message);
}

class InvalidCredentialsException implements Exception {
  final String message;

  InvalidCredentialsException(this.message);
}

class InvalidQRException implements Exception {
  final String message;

  InvalidQRException(this.message);
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

void checkQR(String code) {
  final validMonths = [
    "EN",
    "FE",
    "MA",
    "AB",
    "MY",
    "JU",
    "JL",
    "AG",
    "SE",
    "OC",
    "NO",
    "DI"
  ];
  final validMACs = ["30", "40", "50", "60", "99"];
  final validModels = [
    "000024R950",
    "000042I800",
    "00027R1000",
    "000036I600",
    "0000036600",
    "000034R850",
    "0000034850",
    "0000341000",
    "00034R1000",
    "00004D1350",
    "0NS60ZL(S)",
    "00NS60Z(S)",
    "0000024800",
    "0000034700",
    "0000042700",
    "00004D1350",
    "00030H1100",
    "0000027750",
    "0000651000"
  ];

  if (code.isEmpty) {
    throw GeneralException("No se pudo obtener el código.");
  }

  try {
    String fabricationMonth = code.substring(0, 2);
    //String merchansideLine = code.substring(2, 4);
    String familyCode = code.substring(4, 6);
    //String barCode = code.substring(6, 18);
    //String expirationCode = code.substring(18, 20);
    //String fabricationDate = code.substring(20, 28);
    String model = code.substring(28, 38);
    //String expirationDate = code.substring(38, 46);
    //String lastDigits = code.substring(46, 48);
    //String daysBetweenExpirationAndFabrication = code.substring(48, 51);
    //String sequencial = code.substring(51);

    if (code.length != 59 ||
        !(validMonths.contains(fabricationMonth)) ||
        !(validMACs.contains(familyCode)) ||
        !(validModels.contains(model))) {
      throw InvalidQRException(
          "El código escaneado no corresponde a un número de serie");
    }
  } on InvalidQRException catch (e) {
    throw InvalidQRException(e.message);
  }
}
