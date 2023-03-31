import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:task/utils/utils.dart';

class CardShimmer extends StatelessWidget {
  const CardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: width(context) * .4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          width: width(context) * .37, height: 80),
                    ),
                    const SizedBox(height: 10),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: 16,
                          width: width(context) * .37,
                          borderRadius: BorderRadius.circular(8)),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
