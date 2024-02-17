import 'dart:developer';

import 'package:get/get.dart';
import 'package:tr_store/app/data/models/products.dart';
import 'package:tr_store/app/services/product_db.dart';

class CartController extends GetxController {
  final productsList = <Products>[].obs;

  @override
  void onReady() {
    getProducts();
    super.onReady();
  }

  Future<void> addProduct({required Products product}) async {
    try {
      await DatabaseHelper.insertProduct(product);
    } catch (e) {}
    getProducts();
  }

  var totalPrice = 0.obs;
  Future<List<Products>> getProducts() async {
    productsList.value = await DatabaseHelper.getAllProducts();
    totalPrice.value = 0;
    for (var element in productsList) {
      totalPrice.value = totalPrice.value + element.userId! * element.count!;
    }
    return productsList;
  }

  Future<void> deleteProduct({required Products product}) async {
    await DatabaseHelper.deleteProduct(product.id!);
    getProducts();
  }

  Future<void> updateProduct({required Products product}) async {
    await DatabaseHelper.updateProduct(product);
    getProducts();
  }

  bool isProductAvailableInCart(String productId) {
    var isProductAvailable = false;
    productsList.forEach((element) {
      if (element.id.toString() == productId) {
        isProductAvailable = true;
      }
    });
    return isProductAvailable;
  }

  void decreaseProductCount(Products product) {
    if (product.count! > 1) {
      product.count = product.count! - 1;
      Get.find<CartController>().updateProduct(product: product);
    } else {
      Get.find<CartController>().deleteProduct(product: product);
    }
    getProducts();
  }

  void increaseProductCount(Products product) async {
    product.count = product.count! + 1;
    await Get.find<CartController>().updateProduct(product: product);
    getProducts();
  }
}
