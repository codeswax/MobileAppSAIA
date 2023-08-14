class Battery {
  final String familyCode;
  final String model;

  Battery({
    required this.familyCode,
    required this.model,
  });

  static String getProductNameFromFamilyCode(String familyCode) {
    final familyCodeMap = {
      "30": "MAC SILVER",
      "40": "MAC GOLD",
      "50": "MAC AGM",
      "60": "MAC OPTIMA",
      "99": "OTRAS BATERIAS MAC",
    };
    return familyCodeMap[familyCode] ?? "Desconocido";
  }
}
