import 'package:flutter/material.dart';
import 'package:martes_emp_qr/provider/http.dart';
import 'package:martes_emp_qr/src/helpers/localdb.dart';
import 'package:martes_emp_qr/src/models/products.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> products = [];

  Future<void> getAllProducts() async {
    final productsFromDB = await getWithToken('api/employee/products');
    final products = parseItems(productsFromDB.body);

    this.products = products;

    DatabaseHelper dbHelper = DatabaseHelper();

    await dbHelper.resetTable();

    //!funcion para borrar la tabla y comenzar denuevo.
    // await dbHelper.clearTable();

    for (Product product in products) {
      await dbHelper.insertProducto(product);
    }

    return;
  }

  Future<List<Product>> getProductsFromDb() async {
    DatabaseHelper dbHelper = DatabaseHelper();

    List<Product> productosGuardados = await dbHelper.getProductos();

    products = productosGuardados;

    return productosGuardados;
  }
}
