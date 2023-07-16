// ignore_for_file: prefer_const_constructors

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:martes_emp_qr/provider/cart.provider.dart';
import 'package:martes_emp_qr/provider/ui.provider.dart';
import 'package:martes_emp_qr/src/constants/sizes.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class ScanProductScreen extends StatelessWidget {
  ScanProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Porfavor coloque un codigo de barras al frente de la camara.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 30),
              ScanProduct(),
              Container(
                margin: EdgeInsets.only(top: 50),
                child:
                    cartProvider.isLoading ? CircularProgressIndicator() : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ScanProduct extends StatelessWidget {
  const ScanProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);
    final height = mediaQ.size.height;
    final finalHeight = height * .4;
    final cartProvider = Provider.of<CartProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: finalHeight,
        width: finalHeight,
        child: cartProvider.isCameraActive
            ? MobileScanner(
                allowDuplicates: false,
                controller: MobileScannerController(
                  facing: CameraFacing.back,
                  torchEnabled: true,
                ),
                onDetect: (barcode, args) async {
                  if (barcode.rawValue == null) {
                    debugPrint('Error al scanear un codigo');
                  } else {
                    final player = AudioPlayer();
                    await player.play(AssetSource('beep.wav'));
                    final String code = barcode.rawValue!;
                    cartProvider.loadingProduct(int.parse(code), context);
                    cartProvider.isCameraActive = false;
                  }
                },
              )
            : Center(child: Text('Holaaaa')),
      ),
    );
  }
}
