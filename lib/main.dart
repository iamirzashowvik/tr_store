import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_store/app/data/values/app_string.dart';
import 'package:tr_store/app/services/product_db.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initDatabase();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
