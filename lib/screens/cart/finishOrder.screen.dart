import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:martes_emp_qr/provider/cart.provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

enum Method { efectivo, deposito, tarjeta }

enum CardType { credit, debit }

class FinishScreen extends StatelessWidget {
  const FinishScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final oCcy = NumberFormat.simpleCurrency();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              'Total a pagar:',
              style: Theme.of(context).textTheme.headlineMedium,
              textScaleFactor: 1,
            ),
            AutoSizeText(
              oCcy.format(cartProvider.totalWhitDiscount),
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              textScaleFactor: 1,
            ),
            const SizedBox(height: 50),
            AutoSizeText(
              'Metodo de pago',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
              textScaleFactor: 1,
            ),
            const NewWidget(),
            const Divider(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SlideAction(
                borderRadius: 12,
                elevation: 0,
                innerColor: Colors.blueGrey.shade800,
                outerColor: Colors.blueGrey.shade200,
                text: 'Enviar Orden',
                onSubmit: () => cartProvider.sendCart(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                activeColor: Colors.blueGrey.shade500,
                value: Method.efectivo,
                groupValue: cartProvider.method,
                onChanged: (Method? method) => cartProvider.setMethod(method!),
              ),
              AutoSizeText(
                'Efectivo',
                style: Theme.of(context).textTheme.titleLarge,
                textScaleFactor: 1,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                activeColor: Colors.blueGrey.shade500,
                value: Method.deposito,
                groupValue: cartProvider.method,
                onChanged: (Method? method) => cartProvider.setMethod(method!),
              ),
              AutoSizeText(
                'Deposito',
                style: Theme.of(context).textTheme.titleLarge,
                textScaleFactor: 1,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                activeColor: Colors.blueGrey.shade500,
                value: Method.tarjeta,
                groupValue: cartProvider.method,
                onChanged: (Method? method) => cartProvider.setMethod(method!),
              ),
              AutoSizeText(
                'Tarjeta',
                style: Theme.of(context).textTheme.titleLarge,
                textScaleFactor: 1,
              ),
            ],
          ),
          Container(
            child: cartProvider.method == Method.tarjeta
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  activeColor: Colors.blueGrey.shade500,
                                  value: CardType.credit,
                                  groupValue: cartProvider.cardType,
                                  onChanged: (CardType? cardType) =>
                                      cartProvider.setCardType(cardType!),
                                ),
                                AutoSizeText(
                                  'Credito',
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textScaleFactor: 1,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  activeColor: Colors.blueGrey.shade500,
                                  value: CardType.debit,
                                  groupValue: cartProvider.cardType,
                                  onChanged: (CardType? cardType) =>
                                      cartProvider.setCardType(cardType!),
                                ),
                                AutoSizeText(
                                  'Debito',
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textScaleFactor: 1,
                                ),
                              ],
                            ),
                          ]),
                    ),
                  )
                : SizedBox(
                    height: 95,
                  ),
          )
        ],
      ),
    );
  }
}
