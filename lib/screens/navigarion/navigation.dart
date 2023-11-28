import 'package:flutter/material.dart';
import 'package:martes_emp_qr/provider/cart.provider.dart';
import 'package:martes_emp_qr/screens/cart/newsell.screen.dart';
import 'package:martes_emp_qr/screens/cart/scan/scan.screen.dart';
import 'package:martes_emp_qr/screens/sells/sells.screen.dart';
import 'package:provider/provider.dart';

import '../../provider/ui.provider.dart';
import '../../widget/custom_nav_bar.dart';
import '../home/home.screen.dart';
import '../home/home_tablet.screen.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    bool isTablet = MediaQuery.of(context).size.width > 1200 ? true : false;

    if (isTablet) {
      return const HomeTabletScreen();
    }

    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: _HomePageBody(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey.shade400,
        disabledElevation: 5,
        onPressed: () => {
          cartProvider.isCameraActive = true,
          uiProvider.selectedMenuOpt = 1
        },
        child: const Icon(
          Icons.qr_code_scanner_sharp,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        return const NewOrderScreen();
      case 2:
        return const SellsScreen();
      case 1:
        return ScanProductScreen();
      default:
        return const NewOrderScreen();
    }
  }
}
