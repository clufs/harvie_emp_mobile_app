import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:martes_emp_qr/provider/products.provider.dart';

import 'package:provider/provider.dart';

import '../../provider/cart.provider.dart';
import '../../src/models/cart.dart';

class HomeTabletScreen extends StatelessWidget {
  const HomeTabletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    Logger().wtf(productsProvider.products.map((e) => e.title));

    return Scaffold(
      backgroundColor: const Color.fromRGBO(17, 19, 21, 1),
      body: SafeArea(
          child: productsProvider.products.isNotEmpty
              ? const Row(
                  children: <Widget>[
                    ProductsContainer(),
                    SummaryWidget(),
                  ],
                )
              : Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Hola!",
                          style: TextStyle(color: Colors.white, fontSize: 70),
                        ),
                        InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                          onTap: () {
                            productsProvider.getAllProducts();
                            // await productsProvider.getProductsFromDb();

                            HapticFeedback.vibrate();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(194, 219, 233, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            width: 200,
                            height: 170,
                            child: const Stack(
                              children: [
                                Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'Obtener Productos',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                )),
    );
  }
}

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat.simpleCurrency();
    final cartProvider = Provider.of<CartProvider>(context);

    return Column(
      children: [
        Expanded(
          child: SizedBox(
            width: 620,
            // color: Colors.amber,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    cartProvider.clearCart();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    ),
                    Text(
                      oCcy.format(cartProvider.total),
                      style: const TextStyle(color: Colors.white, fontSize: 60),
                    )
                  ],
                ),
                Container(
                  height: 200,
                  child: TablaProd(),
                ),
                Container(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class TablaProd extends StatelessWidget {
  const TablaProd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    var textStyle = const TextStyle(
        fontStyle: FontStyle.italic, fontSize: 15, color: Colors.white);
    var textStyle2 = const TextStyle(
        fontStyle: FontStyle.italic, fontSize: 24, color: Colors.white);

    return DataTable(
      columnSpacing: 15,
      showBottomBorder: true,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      columns: [
        DataColumn(label: Text('Cant', style: textStyle)),
        DataColumn(label: Text('Producto', style: textStyle)),
      ],
      rows: cartProvider.cart
          .map(
            (cartItem) => DataRow(
              onLongPress: () => print('borrando'),
              cells: [
                DataCell(Text(
                  '${cartItem.cant}',
                  style: textStyle2,
                )),
                DataCell(Text(
                  cartItem.name,
                  style: textStyle2,
                )),
              ],
            ),
          )
          .toList(),
    );
  }
}

class ProductsContainer extends StatefulWidget {
  const ProductsContainer({
    super.key,
  });

  @override
  State<ProductsContainer> createState() => _ProductsContainerState();
}

class _ProductsContainerState extends State<ProductsContainer> {
  late String categoryActive;
  late List<String> categories;

  @override
  void initState() {
    super.initState();
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final cats =
        productsProvider.products.map((e) => e.category.toLowerCase()).toList();
    categories = Set<String>.from(cats).toList();
    categoryActive = categories[0];
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    List productsToShow = productsProvider.products
        .where((element) =>
            element.category.toLowerCase() == categoryActive.toLowerCase())
        .toList();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Esta es la parte de las categorias.

          Container(
            width: 640,
            child: Row(
              children: [
                Column(
                  children: [
                    InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      onTap: () {
                        categoryActive = categories[0];

                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            // color: Colors.cyan[50],
                            color: const Color.fromRGBO(207, 221, 219, 1),
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0))),
                        width: 200,
                        height: 150,
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 10,
                              child: Icon(
                                Icons.free_breakfast,
                                size: 80,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              child: Text(
                                categories[0],
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      onTap: () {
                        setState(() {
                          categoryActive = categories[1];
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(228, 205, 238, 1),
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0))),
                        width: 200,
                        height: 150,
                        child: Stack(
                          children: [
                            const Positioned(
                                top: 10,
                                child: Icon(
                                  Icons.food_bank_outlined,
                                  size: 80,
                                )),
                            Positioned(
                              bottom: 10,
                              child: Text(
                                categories[1],
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      onTap: () {
                        categoryActive = categories[2];

                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            // color: Colors.cyan[50],
                            color: const Color.fromRGBO(194, 219, 233, 1),
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0))),
                        width: 200,
                        height: 150,
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 10,
                              child: Icon(
                                Icons.soup_kitchen,
                                size: 80,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              child: Text(
                                categories[2],
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 640,
            child: Divider(
              // thickness: 2,
              height: 20,
              color: Colors.white,
            ),
          ),

          //Esta es la parte de los productos

          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     for (var product in productsToShow)
          //       buildProductContainer(product.title, product.priceToSell),
          //   ],
          // ),
          Container(
            width: 700,
            child: Wrap(
              children: [
                for (var product in productsToShow)
                  buildProductContainer(product),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductContainer(product) {
    final cartProvider = Provider.of<CartProvider>(context);
    final oCcy = NumberFormat.simpleCurrency();

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      onTap: () {
        cartProvider.addProduct(
          CartItem(
              name: product.title,
              id: product.id.toString(),
              cant: 1,
              price: product.priceToSell),
        );

        HapticFeedback.vibrate();
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(45, 45, 45, 1),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        width: 200,
        height: 170,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                product.title,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 20,
              child: Text(
                oCcy.format(product.priceToSell),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
