import 'package:flutter/material.dart';
import 'package:martes_emp_qr/provider/sales.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

class SummaryOfDay extends StatelessWidget {
  const SummaryOfDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center();
    // final salesProvider = Provider.of<SalesProvider>(context);

    // Map<String, double> dataMap = {
    //   "Tarjeta": double.parse(salesProvider.totalCard.toString()),
    //   "Efectivo": double.parse(salesProvider.totalCash.toString()),
    //   "Deposito": double.parse(salesProvider.totalTransf.toString()),
    // };

    // return Center(
    //   child: PieChart(
    //     dataMap: dataMap,
    //     legendOptions: const LegendOptions(
    //         legendTextStyle: TextStyle(
    //       fontSize: 20,
    //     )),
    //     chartValuesOptions: const ChartValuesOptions(
    //       chartValueStyle: TextStyle(
    //         fontSize: 17,
    //         color: Colors.black,
    //       ),
    //       decimalPlaces: 0,
    //     ),
    //   ),
    // );
  }
}
