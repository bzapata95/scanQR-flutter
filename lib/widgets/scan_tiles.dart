import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

import '../utils/utils.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        direction: DismissDirection.endToStart,
        onDismissed: (DismissDirection direction) =>
            {scanListProvider.deleteScanById(scans[i].id!)},
        child: ListTile(
            leading: Icon(
                scanListProvider.typeSelected == 'http'
                    ? Icons.home
                    : Icons.map,
                color: Theme.of(context).primaryColor),
            title: Text(scans[i].value),
            subtitle: Text(scans[i].id.toString()),
            trailing:
                const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            onTap: () => launchURL(context, scans[i])),
      ),
      itemCount: scans.length,
    );
  }
}
