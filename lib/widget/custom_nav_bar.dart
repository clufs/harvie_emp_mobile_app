import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ui.provider.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (int index) {
        uiProvider.selectedMenuOpt = index;
      },
      selectedIconTheme: const IconThemeData(color: Colors.black),
      selectedItemColor: Colors.black,
      selectedLabelStyle: const TextStyle(fontSize: 18),
      unselectedLabelStyle: const TextStyle(fontSize: 17),
      unselectedItemColor: Colors.black38,
      elevation: 50,
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.noise_control_off), label: 'Escanear'),
        BottomNavigationBarItem(icon: Icon(Icons.view_list), label: 'Ventas'),
      ],
    );
  }
}
