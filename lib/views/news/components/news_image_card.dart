import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';

class NewsImageCard extends StatelessWidget {
  const NewsImageCard({
    Key? key,
    required this.title,
    required this.topic,
    required this.image,
    required this.time,
  }) : super(key: key);

  final String title;
  final String topic;
  final String image;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // padding: EdgeInsets.symmetric(vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * (2 / 3),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
              )),
        ),
        Positioned(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * (2 / 3),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
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
            top: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 140,
                ),
                const Icon(
                  Icons.bookmark_add_outlined,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.share,
                  color: Colors.white,
                )
              ],
            )),
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
                  // AppText.captionMedium("5 mins read"),
                  const SizedBox(
                    width: 15,
                  ),
                  AppText.captionMedium(time)
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(right: 10),
                child: AppText.heading(
                  title,
                  height: 1.1,
                  multitext: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AppText.captionMedium("2,500"),
                  const SizedBox(
                    width: 15,
                  ),
                  const Icon(
                    Icons.thumb_up_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AppText.captionMedium("500"),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
