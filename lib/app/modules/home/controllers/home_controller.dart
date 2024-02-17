import 'dart:convert';
import 'package:get/get.dart';
import 'package:tr_store/app/data/models/products.dart';
import 'package:tr_store/app/data/providers/network_request.dart';
import 'package:tr_store/app/modules/cart/controllers/cart_controller.dart';

class HomeController extends GetxController with StateMixin<List<Products>> {
  @override
  void onInit() {
    Get.put(CartController());
    getProducts();
    getLocalProducts();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getProducts() async {
    await NetworkRequest(url: '/posts').get(beforeSend: () {
      change([], status: RxStatus.loading());
    }, onSuccess: (result) {
      final products = productsFromJson(jsonEncode(result));

      change(products, status: RxStatus.success());
    }, onError: (error) {
      change([], status: RxStatus.error());
    });
  }

  addToCart(Products product) async {
    await Get.find<CartController>().addProduct(product: product);
    getLocalProducts();
  }

  var localProductsList = <Products>[].obs;
  getLocalProducts() async {
    localProductsList.value = await Get.find<CartController>().getProducts();
  }

  bool isProductAvailableInCart(String productId) {
    return Get.find<CartController>().isProductAvailableInCart(productId);
  }
}
