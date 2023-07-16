import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:martes_emp_qr/provider/sales.dart';
import 'package:martes_emp_qr/screens/cart/widgets/Total.dart';
import 'package:martes_emp_qr/screens/sells/sells.screen.dart';
import 'package:martes_emp_qr/src/constants/sizes.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final saleProvider = Provider.of<SalesProvider>(context);
    final saleId = ModalRoute.of(context)!.settings.arguments as String;
    final oCcy = NumberFormat.simpleCurrency();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(paddingSize),
          child: FutureBuilder(
            future: saleProvider.getSale(saleId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const LoadingWidget();
              }

              return Container(
                child: snapshot.data!.isEmpty
                    ? null
                    : Column(
                        children: [
                          TotalWidget(total: snapshot.data!['total']),
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                              itemCount: snapshot.data!['cart'].length,
                              itemBuilder: (context, index) {
                                final subtotal = snapshot.data!['cart'][index]
                                        ['cant'] *
                                    snapshot.data!['cart'][index]['price'];
                                return ListTile(
                                  title: Text(
                                    snapshot.data!['cart'][index]['name'],
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  subtitle: snapshot.data!['cart'][index]
                                              ['cant'] >
                                          1
                                      ? Text(
                                          '${snapshot.data!['cart'][index]['cant']} unidades',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        )
                                      : Text(
                                          '${snapshot.data!['cart'][index]['cant']} unidad'),
                                  trailing: Column(
                                    children: [
                                      Text(
                                        oCcy.format(subtotal),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      Text(
                                        '${oCcy.format(snapshot.data!['cart'][index]['price'])} c/u.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
