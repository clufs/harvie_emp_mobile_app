// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:martes_emp_qr/provider/login.provider.dart';
import 'package:martes_emp_qr/screens/login/login_screen.dart';
import 'package:martes_emp_qr/screens/navigarion/navigation.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Lottie.asset('assets/waiting.json'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authServices = Provider.of<LoginProvider>(context);

    final autenticado = await authServices.checkLogin();

    if (autenticado) {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => Navigation(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginScreenv2(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
