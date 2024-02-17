import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_store/app/data/theme/style.dart';
import 'package:tr_store/app/data/values/app_string.dart';
import 'package:tr_store/app/routes/app_pages.dart';
import 'package:tr_store/app/widgets/go_to_cart_button.dart';
import 'package:tr_store/app/widgets/shimmer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.appName),
        centerTitle: true,
        actions: [goToCart()],
      ),
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: state!.length,
          padding: EdgeInsets.symmetric(horizontal: regular),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.PRODUCT_DETAILS,
                    arguments: state[index].id.toString());
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(regular),
                        child: Image.network(
                          state[index].image!,
                          width: Get.width / 4,
                        ),
                      ),
                      SizedBox(width: regular),
                      Flexible(child: Text(state[index].title!)),
                      Obx(() => controller.isProductAvailableInCart(
                              state[index].id.toString())
                          ? Text(
                              'Added',
                              style: rgBold,
                            )
                          : GestureDetector(
                              onTap: () {
                                controller.addToCart(state[index]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: boxColor,
                                    borderRadius:
                                        BorderRadius.circular(regular)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Add To Cart', style: rgBold),
                                ),
                              ),
                            ))
                    ],
                  ),
                  SizedBox(
                    height: regular,
                  )
                ],
              ),
            );
          },
        ),
        onLoading: ListView.separated(
          itemCount: 5,
          padding: EdgeInsets.all(regular),
          itemBuilder: (context, index) => const ProductShimmer(),
          separatorBuilder: (context, index) => SizedBox(height: regular),
        ),
        onEmpty: const Text('No data found'),
        onError: (error) => const Text('error'),
      ),
    );
  }
}
