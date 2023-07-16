import 'package:logger/logger.dart';
import 'package:martes_emp_qr/provider/login.provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanCam extends StatelessWidget {
  const ScanCam({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: MobileScanner(
          allowDuplicates: false,
          controller: MobileScannerController(
            facing: CameraFacing.back,
            torchEnabled: false,
          ),
          onDetect: (barcode, args) async {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;
              final resp = await loginProvider.login(code);
              if (resp) {
                Navigator.pushReplacementNamed(context, 'navigation');
              }
            }
          }),
    );
  }
}
