import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:martes_emp_qr/provider/ui.provider.dart';
import 'package:martes_emp_qr/src/models/products.dart';
import 'package:provider/provider.dart';

import '../../../../provider/cart.provider.dart';
import '../../../../src/models/cart.dart';

mySheet(BuildContext context, Product product) {
  TextEditingController cantController = TextEditingController();
  final cartProvider = Provider.of<CartProvider>(context, listen: false);
  final uiProvider = Provider.of<UiProvider>(context, listen: false);

  showModalBottomSheet(
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: SizedBox(
                height: 200,
                child: Column(
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text('\$${product.priceToSell}',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    SizedBox(
                      width: 200,
                      child: TextField(
                          enableSuggestions: false,
                          onSubmitted: (value) => {
                                cartProvider.addProduct(CartItem(
                                    name: product.title,
                                    id: product.id.toString(),
                                    cant: int.parse(cantController.text),
                                    price: product.priceToSell)),
                                uiProvider.selectedMenuOpt = 0,
                                Navigator.pushReplacementNamed(
                                  context,
                                  'navigation',
                                ),
                              },
                          controller: cantController,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 28.0, height: 1.0, color: Colors.black),
                          decoration: const InputDecoration(
                              labelText: "Ingrese la cantidad."),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).then(
    (isManuallyHidden) {
      if (isManuallyHidden ?? false) {
        Logger().wtf('Paso por el boton de agregar al carrito');
      } else {
        uiProvider.selectedMenuOpt = 0;
        Navigator.pushReplacementNamed(
          context,
          'navigation',
        );
        Logger().v('Clicleo afuera mono. :C');
      }
    },
  );
}
