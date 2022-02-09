import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 0,
        onPressed: () async {
          // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          //     '#3D8BEF', 'Cancelar', false, ScanMode.QR);
          // const String barcodeScanRes = 'https://github.com/bzapata95';
          const String barcodeScanRes = 'geo:-13.1666074,-74.21508';

          if (barcodeScanRes == '-1') return;

          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);
          final scan = await scanListProvider.addScan(barcodeScanRes);
          launchURL(context, scan);
        },
        child: const Icon(Icons.filter_center_focus));
  }
}
