import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:martes_emp_qr/screens/login/widget/Scan_Widget.dart';
import 'package:martes_emp_qr/src/constants/sizes.dart';
import 'package:martes_emp_qr/src/constants/text.dart';

class LoginScreenv2 extends StatelessWidget {
  const LoginScreenv2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              login_saludo,
              style: theme.headline2,
              textAlign: TextAlign.center,
            ),
            AutoSizeText(
              login_intructivo,
              style: theme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              iconSize: 60,
              onPressed: () => Navigator.pushReplacementNamed(context, 'scan'),
            )
          ],
        ),
      ),
    );
  }
}
