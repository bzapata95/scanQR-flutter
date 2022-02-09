import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String typeSelected = 'http';

  Future<ScanModel> addScan(String valor) async {
    final scan = ScanModel(value: valor);
    final id = await DBProvider.db.addScan(scan);
    scan.id = id;

    if (typeSelected == scan.type) {
      scans.add(scan);
      notifyListeners();
    }

    return scan;
  }

  getScans() async {
    final scans = await DBProvider.db.getScanAll();
    this.scans = [...scans];
    notifyListeners();
  }

  getScanByType(String type) async {
    final scans = await DBProvider.db.getScanByType(type);
    this.scans = [...scans];
    typeSelected = type;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    scans.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
