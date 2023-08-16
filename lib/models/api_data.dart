import 'receipt_data.dart';

class LoginData {
  final String user;
  final String pass;
  final String local;

  LoginData(this.user, this.pass, this.local);
}

class ReceiptQueryData {
  final num local;
  final String docType;
  final num docId;

  ReceiptQueryData(this.local, this.docType, this.docId);
}

class SerialAssignmentData {
  final String serial;
  final String user;
  final Receipt receipt;

  SerialAssignmentData(this.serial, this.user, this.receipt);
}

class DocumentData {
  final String doc;

  DocumentData(this.doc);
}

class SerialInsertionData {
  final String productCode;
  final String receiptCode;
  final String token;
  final String user;
  final int local;
  final String docType;

  SerialInsertionData(this.productCode, this.receiptCode, this.token, this.user,
      this.local, this.docType);
}

String localString(num local) {
  return local.toString();
}
