import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:martes_emp_qr/provider/products.provider.dart';
import 'package:provider/provider.dart';

class HomeTabletScreen extends StatelessWidget {
  const HomeTabletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    Logger().wtf(productsProvider.products.map((e) => e.title));

    return Scaffold(
      backgroundColor: Color.fromRGBO(17, 19, 21, 1),
      body: SafeArea(
          child: productsProvider.products.isNotEmpty
              ? Row(
                  children: <Widget>[
                    ProductsContainer(),
                  ],
                )
              : Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hola!",
                          style: TextStyle(color: Colors.white, fontSize: 70),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          onTap: () {
                            productsProvider.getAllProducts();
                            // await productsProvider.getProductsFromDb();

                            HapticFeedback.vibrate();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                                color: const Color.fromRGBO(194, 219, 233, 1),
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

class ProductsContainer extends StatefulWidget {
  const ProductsContainer({
    super.key,
  });

  @override
  State<ProductsContainer> createState() => _ProductsContainerState();
}

class _ProductsContainerState extends State<ProductsContainer> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    final cats =
        productsProvider.products.map((e) => e.category.toLowerCase()).toList();

    final categories = Set<String>.from(cats).toList();

    var cateroryActive = 'indumentaria';
    var productsToShow = productsProvider.products
        .where((element) => element.category == cateroryActive)
        .toList();

    print(productsToShow);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Esta es la parte de las categorias.
          Row(
            children: [
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    onTap: () {},
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
                          Positioned(
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
                              style: TextStyle(fontSize: 25),
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
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          // color: Colors.cyan[50],
                          color: const Color.fromRGBO(228, 205, 238, 1),
                          border: Border.all(color: Colors.white),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0))),
                      width: 200,
                      height: 150,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 10,
                              child: Icon(
                                Icons.food_bank_outlined,
                                size: 80,
                              )),
                          Positioned(
                            bottom: 10,
                            child: Text(
                              categories[1],
                              style: TextStyle(fontSize: 25),
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
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    onTap: () {},
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
                          Positioned(
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
                              style: TextStyle(fontSize: 25),
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

          const SizedBox(
            width: 840,
            child: Divider(
              // thickness: 2,
              height: 20,
              color: Colors.white,
            ),
          ),

          //Esta es la parte de los productos
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    onTap: () {
                      print('hola putas de mierda');
                      HapticFeedback.vibrate();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(45, 45, 45, 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      width: 200,
                      height: 170,
                      child: const Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              'Remera Modal Adultos',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          Positioned(
                              bottom: 20,
                              child: Text(
                                '4.500',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    width: 200,
                    height: 170,
                    child: const Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Remera Modal ninos',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Positioned(
                            bottom: 20,
                            child: Text(
                              '4.000',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    width: 200,
                    height: 170,
                    child: const Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Gorra Trucker Gab',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Positioned(
                            bottom: 20,
                            child: Text(
                              '4.500',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    width: 200,
                    height: 170,
                    child: const Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Gorra Trucker Basica',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Positioned(
                            bottom: 20,
                            child: Text(
                              '4.000',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    width: 200,
                    height: 170,
                    child: const Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Gorra Algodon Vin',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Positioned(
                            bottom: 20,
                            child: Text(
                              '6.000',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    width: 200,
                    height: 170,
                    child: const Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Piluso',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Positioned(
                            bottom: 20,
                            child: Text(
                              '3.000',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    width: 200,
                    height: 170,
                    child: const Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Musculosa',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Positioned(
                            bottom: 20,
                            child: Text(
                              '4.800',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
