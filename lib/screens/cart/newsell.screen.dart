import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:martes_emp_qr/provider/cart.provider.dart';
import 'package:martes_emp_qr/provider/products.provider.dart';
import 'package:martes_emp_qr/screens/cart/widgets/Total.dart';
import 'package:provider/provider.dart';

class NewOrderScreen extends StatelessWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          'Actualizar Productos',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await productsProvider.getAllProducts();
                await productsProvider.getProductsFromDb();
                Logger().wtf(productsProvider.products.length);
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              )),
        ],
      ),
      body: Container(
          height: double.infinity,
          child: cartProvider.cart.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.remove_shopping_cart_sharp,
                        size: 150,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Aun no cargaste ningun producto.',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : OrderWidget(cartProvider: cartProvider)),
    );
  }
}

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    Key? key,
    required this.cartProvider,
  }) : super(key: key);

  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CartAccions(cartProvider: cartProvider),
        TotalWidget(total: cartProvider.total),
        const OrderList(),
      ],
    );
  }
}

class CartAccions extends StatelessWidget {
  const CartAccions({
    Key? key,
    required this.cartProvider,
  }) : super(key: key);

  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => cartProvider.clearCart(),
          child: Row(
            children: [
              Icon(
                Icons.delete,
                color: Colors.red.shade300,
              ),
              Text(
                'Vaciar Carrito.',
                style: TextStyle(color: Colors.red.shade300),
              )
            ],
          ),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, '[new_Order]finish_new_order'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check),
              Text('Terminar orden'),
            ],
          ),
        )
      ],
    );
  }
}

class OrderList extends StatelessWidget {
  const OrderList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontStyle: FontStyle.italic, fontSize: 30);
    var textStyle2 = const TextStyle(fontStyle: FontStyle.italic, fontSize: 30);
    final mediaQuery = MediaQuery.of(context);
    Logger().wtf(mediaQuery.size.width);
    final heigth = mediaQuery.size.height;
    final cartProvider = Provider.of<CartProvider>(context);
    final oCcy = NumberFormat.simpleCurrency();

    return SizedBox(
      height: heigth * .55,
      child: FittedBox(
        alignment: Alignment.topCenter,
        child: DataTable(
            columnSpacing: 37,
            showBottomBorder: true,
            columns: [
              DataColumn(label: Text('Cant', style: textStyle)),
              DataColumn(label: Text('Producto', style: textStyle)),
              DataColumn(label: Text('Precio', style: textStyle)),
              DataColumn(label: Text('Subtotal', style: textStyle)),
            ],
            rows: cartProvider.cart
                .map((cartItem) =>
                    DataRow(onLongPress: () => print('borrando'), cells: [
                      DataCell(Text(
                        '${cartItem.cant}',
                        style: textStyle2,
                      )),
                      DataCell(Text(
                        cartItem.name,
                        style: textStyle2,
                      )),
                      DataCell(Text(
                        oCcy.format(cartItem.price),
                        style: textStyle2,
                      )),
                      DataCell(Text(
                        oCcy.format(cartItem.cant * cartItem.price),
                        style: textStyle2,
                      ))
                    ]))
                .toList()),
      ),
    );
  }
}
