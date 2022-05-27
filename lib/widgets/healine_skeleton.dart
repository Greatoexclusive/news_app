import 'package:flutter/material.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/widgets/skeleton.dart';
import 'package:shimmer/shimmer.dart';

class HeadlineSkeletonCard extends StatelessWidget {
  const HeadlineSkeletonCard({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: kPrimaryLightColor.withOpacity(0.5),
          highlightColor: kSkelenton,
          child: Container(
            // height: 200,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(10),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: kSkelenton),
            child: Row(
              children: [
                Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 90,
                    width: 80,
                    child: const Skeleton()),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Skeleton(
                          height: 12,
                          width: MediaQuery.of(context).size.width - 185,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Skeleton(
                          width: 180,
                          height: 10,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Skeleton(
                          width: 150,
                          height: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Skeleton(
                      width: 60,
                      height: 10,
                    )
                  ],
                ),
                const Skeleton(
                  width: 20,
                  height: 20,
                )
              ],
            ),

            // child: BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
            // ),
          ),
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
