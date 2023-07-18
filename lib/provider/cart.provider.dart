import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:martes_emp_qr/provider/http.dart';
import 'package:martes_emp_qr/provider/products.provider.dart';
import 'package:martes_emp_qr/screens/cart/finishOrder.screen.dart';
import 'package:martes_emp_qr/screens/cart/scan/widgets/modal.dart';
import 'package:martes_emp_qr/src/models/products.dart';
import 'package:provider/provider.dart';
import '../src/models/cart.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> cart = [];
  late int total = 0;
  late int totalProducts = 0;

  late int totalWhitDiscount = 0;
  final discount = 0;
  final totalForDiscount = 999999;

  //testing----------
  bool _isCameraActive = true;
  bool get isCameraActive => _isCameraActive;

  set isCameraActive(bool value) {
    _isCameraActive = value;
    notifyListeners();
  }
  //-------------------------

  Method method = Method.efectivo;

  bool isLoading = false;

  Future loadingProduct(int qrCode, context) async {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    String data = json.encode({'id': qrCode});

    Logger().wtf(data);

    if (true) {
      isLoading = true;

      //obtenemos el producto desde la base de datos local.
      final products = await productsProvider.getProductsFromDb();

      try {
        Product productoEncontrado = products.firstWhere(
          (element) => element.id == qrCode,
        );
        Logger().wtf(productoEncontrado);
        _showModal(context, productoEncontrado);
        isLoading = false;
        notifyListeners();
        return true;
      } catch (e) {
        print('producto no encontrado');
        isLoading = false;
        notifyListeners();
        return false;
      }
    }
  }

  addProduct(CartItem product) {
    cart.add(product);
    _total();
    notifyListeners();
  }

  _showModal(context, prod) {
    mySheet(context, prod);
  }

  _total() {
    total = 0;
    totalProducts = 0;
    for (var element in cart) {
      {
        total = total + element.price * element.cant;
        totalProducts = totalProducts + element.cant;
      }
    }
    if (total > totalForDiscount) {
      int descuento = (total ~/ 5000).toInt();
      int totalDescuento = descuento * discount;

      totalWhitDiscount = total - totalDescuento;
    } else {
      totalWhitDiscount = total;
    }

    notifyListeners();
  }

  clearCart() {
    cart = [];
    total = 0;
    totalProducts = 0;
    notifyListeners();
  }

  Future<bool> sendCart(context) async {
    isLoading = true;
    notifyListeners();
    final data = {
      'cart': cart,
      'payment_method': method.name,
    };
    final finalData = json.encode(data);
    Response resp = await postWithToken('api/sales', finalData);
    Logger().wtf(resp.body);
    if (resp.statusCode == 201) {
      isLoading = false;
      clearCart();
      Navigator.pop(context);
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  setMethod(Method method) {
    this.method = method;
    notifyListeners();
  }
}
