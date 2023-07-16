import 'package:flutter/material.dart';
import 'package:martes_emp_qr/provider/login.provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: Center(
        child: Text(
          'Bienvenido ${authProvider.name}',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
