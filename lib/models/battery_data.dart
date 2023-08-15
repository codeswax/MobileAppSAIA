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
    return familyCodeMap[familyCode] ?? "Unknown";
  }

  static String getProductModelFromFamilyCode(String model) {
    final modelNameMap = {
      "000024R950": "24R950",
      "000042I800": "42I800",
      "00027R1000": "27R1000",
      "000036I600": "36I600",
      "0000036600": "36600",
      "000034R850": "34R850",
      "0000034850": "34850",
      "0000341000": "341000",
      "00034R1000": "34R1000",
      "00004D1350": "4D1350",
      "0NS60ZL(S)": "NS60ZL(S)",
      "00NS60Z(S)": "NS60Z(S)",
      "0000024800": "24800",
      "0000034700": "34700",
      "0000042700": "42700",
      "00030H1100": "30H1100",
      "0000027750": "27750",
      "0000651000": "651000",
      "0000NS40ZL": "NS40ZL",
    };
    return modelNameMap[model] ?? "Unknown";
  }
}
