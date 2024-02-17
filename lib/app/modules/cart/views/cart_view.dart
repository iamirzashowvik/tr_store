import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tr_store/app/data/theme/style.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () => controller.productsList.isEmpty
              ? Center(
                  child: Text(
                    'No product added to the cart',
                    style: rgBold,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: regular),
                        itemCount: controller.productsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: regular),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(regular),
                                  child: Image.network(
                                    controller.productsList[index].image!,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                  ),
                                ),
                                SizedBox(width: regular),
                                Flexible(
                                    flex: 3,
                                    child: Text(
                                        controller.productsList[index].title!)),
                                Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      "\$${controller.productsList[index].userId! * controller.productsList[index].count!}",
                                      style: rgBold,
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            backgroundColor: Colors.black12,
                                            child: IconButton(
                                              onPressed: () {
                                                controller.decreaseProductCount(
                                                    controller
                                                        .productsList[index]);
                                              },
                                              icon: const Icon(Icons.minimize),
                                            )),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: regular * 1.3),
                                          child: Text(
                                            controller.productsList[index].count
                                                .toString(),
                                            style: rgBold.copyWith(
                                                fontSize: titleSize),
                                          ),
                                        ),
                                        CircleAvatar(
                                            backgroundColor: boxColor,
                                            child: IconButton(
                                              onPressed: () {
                                                controller.increaseProductCount(
                                                    controller
                                                        .productsList[index]);
                                              },
                                              icon: Icon(Icons.add),
                                            )),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(regular * 2),
                        child: Row(
                          children: [
                            Text(
                              'Total Price',
                              style: rgBold,
                            ),
                            const Spacer(),
                            Text(
                              controller.totalPrice.value.toString(),
                              style: rgBold,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
