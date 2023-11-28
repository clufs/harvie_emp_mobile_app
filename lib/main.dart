import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:martes_emp_qr/provider/cart.provider.dart';
import 'package:martes_emp_qr/provider/login.provider.dart';
import 'package:martes_emp_qr/provider/products.provider.dart';
import 'package:martes_emp_qr/provider/sales.dart';
import 'package:martes_emp_qr/provider/ui.provider.dart';
import 'package:martes_emp_qr/screens/cart/finishOrder.screen.dart';
import 'package:martes_emp_qr/screens/cart/newsell.screen.dart';
import 'package:martes_emp_qr/screens/home/home.screen.dart';
import 'package:martes_emp_qr/screens/login/login_screen.dart';
import 'package:martes_emp_qr/screens/login/widget/Scan_Widget.dart';
import 'package:martes_emp_qr/screens/navigarion/loading.screen.dart';
import 'package:martes_emp_qr/screens/navigarion/navigation.dart';
import 'package:martes_emp_qr/screens/sells/order.screen.dart';
import 'package:martes_emp_qr/screens/sells/summaryOfDay.screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SalesProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        routes: {
          'scan': (_) => const ScanCam(),
          'login': (_) => const LoginScreenv2(),
          'home': (_) => const HomeScreen(),
          'loading': (_) => const LoadingScreen(),
          '[new_Order]new_order': (_) => const NewOrderScreen(),
          '[new_Order]finish_new_order': (_) => const FinishScreen(),
          'navigation': (_) => const Navigation(),
          '[orders}order': (_) => const SellScreen(),
          'summary_of_day': (_) => const SummaryOfDay(),
        },
        initialRoute: 'loading',
      ),
    );
  }
}
