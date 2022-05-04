import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryItemShimmer extends StatelessWidget {
  const CategoryItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300] as Color,
              highlightColor: Colors.grey[100] as Color,
              child: Container(
                width: 90,
                height: 15,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
            );
          }),
    );
  }
}
