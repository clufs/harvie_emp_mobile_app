import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:martes_emp_qr/src/constants/sizes.dart';
import 'package:provider/provider.dart';
import '../../provider/sales.dart';

class SellsScreen extends StatelessWidget {
  const SellsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sellsProvider = Provider.of<SalesProvider>(context);

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(paddingSize),
          child: FutureBuilder(
            future: sellsProvider.getSalesOfToday(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const LoadingWidget();
              }
              return Container(
                child: snapshot.data!.isEmpty ? Text('Sin ordenes') : HasData(),
              );
            },
          )),
    );
  }
}

class HasData extends StatelessWidget {
  const HasData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sellsProvider = Provider.of<SalesProvider>(context);
    final oCcy = NumberFormat.simpleCurrency();

    return Column(
      children: [
        Text(
          'Ventas del dia',
          style: Theme.of(context).textTheme.headline4,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: sellsProvider.sales.length,
            itemBuilder: ((context, index) {
              return ListTile(
                onTap: () => Navigator.pushNamed(context, '[orders}order',
                    arguments: sellsProvider.sales[index]['id']),
                title: Text(oCcy.format(sellsProvider.sales[index]['total'])),
                trailing: Text(
                  sellsProvider.sales[index]['payment_method']
                      .toString()
                      .toUpperCase(),
                  style: TextStyle(
                    color: sellsProvider.sales[index]['payment_method'] ==
                            'efectivo'
                        ? Colors.green.shade700
                        : Colors.blue.shade700,
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/find.json'),
          Text(
            'Buscando ordenes...',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
