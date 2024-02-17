import 'package:flutter/material.dart';
import 'package:tr_store/app/data/theme/style.dart';

class Shimmers extends StatelessWidget {
  const Shimmers({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: const BorderRadius.all(Radius.circular(14))),
    );
  }
}

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Shimmers(height: 120, width: 120),
        SizedBox(width: regular),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Shimmers(width: 80),
              SizedBox(height: regular / 2),
              const Shimmers(),
              SizedBox(height: regular / 2),
              const Shimmers(),
              SizedBox(height: regular / 2),
              Row(
                children: [
                  const Expanded(
                    child: Shimmers(),
                  ),
                  SizedBox(width: regular),
                  const Expanded(
                    child: Shimmers(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
