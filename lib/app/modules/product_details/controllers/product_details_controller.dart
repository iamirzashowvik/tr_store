import 'dart:convert';
import 'package:get/get.dart';
import 'package:tr_store/app/data/models/products.dart';
import 'package:tr_store/app/data/providers/network_request.dart';
import 'package:tr_store/app/modules/cart/controllers/cart_controller.dart';

class ProductDetailsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getProduct(Get.arguments);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var product = Products().obs;
  getProduct(String id) async {
    await NetworkRequest(url: '/posts/$id').get(
        beforeSend: () {},
        onSuccess: (result) {
          product.value = productFromJson(jsonEncode(result));
        },
        onError: (error) {});
  }

  var productCount = 1.obs;
  void addToCart() async {
    product.value.count = productCount.value;
    await Get.find<CartController>().addProduct(product: product.value);
  }

  void increaseProduct() {
    productCount++;
  }

  void decreaseProduct() {
    if (productCount.value > 1) {
      productCount--;
    }
  }

  bool isProductAvailableInCart(String productId) {
    return Get.find<CartController>().isProductAvailableInCart(productId);
  }
}
