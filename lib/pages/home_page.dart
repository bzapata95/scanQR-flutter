import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/addresses_page.dart';
import 'package:qr_reader/pages/maps_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial'), actions: [
        IconButton(
            onPressed: () {
              final scanListProvider =
                  Provider.of<ScanListProvider>(context, listen: false);

              scanListProvider.deleteAll();
            },
            icon: const Icon(Icons.delete_forever))
      ]),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigatorBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // GET SELECTED MENU OPTIONS
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    // Use Scan List Provider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.getScanByType('geo');
        return MapsPage();
      case 1:
        scanListProvider.getScanByType('http');
        return AddressesPage();
      default:
        return MapsPage();
    }
  }
}
