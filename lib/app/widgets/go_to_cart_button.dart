import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_store/app/modules/cart/controllers/cart_controller.dart';
import 'package:tr_store/app/routes/app_pages.dart';

Widget goToCart() {
  return IconButton(
      onPressed: () {
        Get.toNamed(Routes.CART);
      },
      icon: const Icon(Icons.local_grocery_store));
}
