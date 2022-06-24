import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';

class FirstNewsCard extends StatelessWidget {
  const FirstNewsCard({
    Key? key,
    required this.title,
    required this.topic,
    required this.image,
    required this.time,
    required this.rights,
  }) : super(key: key);
  final String title;
  final String topic;
  final String image;
  final String time;
  final String rights;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        children: [
          SizedBox(
            // padding: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 400,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          )),
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AppText.captionMedium(
                        topic,
                        color: kPrimaryColor,
                      ),
                      decoration: BoxDecoration(
                          color: kTabColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    // AppText.captionMedium("5 mins read")
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: AppText.heading(
                    title,
                    height: 1.1,
                    multitext: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    AppText.captionMedium(rights),
                    AppText.captionMedium("   |   "),
                    AppText.captionMedium(time)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
