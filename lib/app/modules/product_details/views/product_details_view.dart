import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_store/app/data/theme/style.dart';
import 'package:tr_store/app/modules/product_details/widgets/add_to_cart_button.dart';
import 'package:tr_store/app/widgets/go_to_cart_button.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.product.value.title == null
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : Scaffold(
              appBar: AppBar(
                title: const Text('Details'),
                actions: [goToCart()],
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(controller.product.value.image ?? ''),
                    Padding(
                      padding: EdgeInsets.all(regular),
                      child: Text(
                        controller.product.value.title ?? '',
                        style: rgBold.copyWith(fontSize: titleSize),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(regular),
                      child: Text(
                        controller.product.value.content ?? '',
                        style: rgBook,
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                  decoration: const BoxDecoration(color: primaryColor),
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: regular * 1.3),
                        child: Obx(() => Text(
                              '\$${controller.productCount.value * controller.product.value.userId!}',
                              style: rgBold.copyWith(
                                  color: Colors.white, fontSize: titleSize),
                            )),
                      ),
                      controller.isProductAvailableInCart(
                              controller.product.value.id!.toString())
                          ? Center(
                              child: Text(
                                'Product is added on cart',
                                style: rgBold.copyWith(color: Colors.white),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: IconButton(
                                          onPressed: () {
                                            controller.decreaseProduct();
                                          },
                                          icon: const Icon(Icons.minimize),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: regular * 1.3),
                                      child: Obx(() => Text(
                                            controller.productCount.value
                                                .toString(),
                                            style: rgBold.copyWith(
                                                color: Colors.white,
                                                fontSize: titleSize),
                                          )),
                                    ),
                                    CircleAvatar(
                                        backgroundColor: boxColor,
                                        child: IconButton(
                                          onPressed: () {
                                            controller.increaseProduct();
                                          },
                                          icon: const Icon(Icons.add),
                                        )),
                                  ],
                                ),
                                addToCartButton(controller.addToCart)
                              ],
                            ),
                    ],
                  )),
            ),
    );
  }
}
