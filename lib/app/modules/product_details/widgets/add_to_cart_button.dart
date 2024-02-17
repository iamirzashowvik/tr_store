import 'package:flutter/material.dart';
import 'package:tr_store/app/data/theme/style.dart';

GestureDetector addToCartButton(Function functions) {
  return GestureDetector(
    onTap: () {
      functions();
    },
    child: Container(
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(regular)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Add To Cart', style: rgBold),
      ),
    ),
  );
}
