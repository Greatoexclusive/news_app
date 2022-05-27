import 'package:flutter/material.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/widgets/skeleton.dart';
import 'package:shimmer/shimmer.dart';

class FirstNewsSkeleton extends StatelessWidget {
  const FirstNewsSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 400,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: const Skeleton(),
              ),
            ),
            const Positioned(
              top: 30,
              right: 20,
              child: Skeleton(
                width: 45,
                height: 45,
              ),
            ),
            Positioned(
              bottom: 30,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Skeleton(
                    width: 50,
                    height: 20,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Skeleton(
                    height: 25,
                    width: 300,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Skeleton(
                    height: 25,
                    width: 250,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Skeleton(
                        width: 100,
                        height: 15,
                      ),
                      AppText.captionMedium("   |   "),
                      const Skeleton(
                        width: 50,
                        height: 15,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      baseColor: kPrimaryLightColor.withOpacity(0.5),
      highlightColor: kSkelenton,
    );
  }
}
