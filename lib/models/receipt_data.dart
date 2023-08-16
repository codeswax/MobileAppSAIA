class Receipt {
  final int localId;
  final String docType;
  final double docId;
  final int detailId;
  final int destinationId;
  final int sequence;
  final String itemId;
  final String itemName;
  final dynamic lotId;
  late dynamic serial;
  final dynamic userRegId;
  final dynamic equipmentReg;
  final dynamic dateReg;

  Receipt({
    required this.localId,
    required this.docType,
    required this.docId,
    required this.detailId,
    required this.destinationId,
    required this.sequence,
    required this.itemId,
    required this.itemName,
    required this.lotId,
    required this.serial,
    required this.userRegId,
    required this.equipmentReg,
    required this.dateReg,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      localId: json['localId'],
      docType: json['documentoTipoId'],
      docId: json['documentoId'],
      detailId: json['detalleId'],
      destinationId: json['localDestinoId'],
      sequence: json['secuencia'],
      itemId: json['itemId'],
      itemName: json['itemNombre'],
      lotId: json['loteId'],
      serial: json['serie'],
      userRegId: json['usuarioRegistroId'],
      equipmentReg: json['equipoRegistro'],
      dateReg: json['fechaRegistro'],
    );
  }
}
