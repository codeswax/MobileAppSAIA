import 'package:saia_mobile_app/models/api_data.dart';

class DataStorage {
  static final DataStorage _instance = DataStorage._internal();

  List<SerialAssignmentData> assignedReceipts = [];

  factory DataStorage() {
    return _instance;
  }

  DataStorage._internal();
}
