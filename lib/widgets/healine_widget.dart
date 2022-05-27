import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/all_functions.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';

class HeadlineCard extends StatelessWidget {
  HeadlineCard({
    Key? key,
    required this.title,
    required this.topic,
    required this.image,
    required this.time,
    required this.rights,
    required this.body,
    required this.handle,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final String topic;
  final String image;
  final String time;
  final String rights;
  final String body;
  final Function()? onPressed;

  final String handle;

  final AllFunction _allFunction = AllFunction();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 200,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(10),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kPrimaryLightColor.withOpacity(0.5),
          ),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 90,
                width: 80,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: image,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: MediaQuery.of(context).size.width - 185,
                    child: AppText.headingMeduim(
                      title,
                      height: 1.1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.captionMedium(time),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.bookmark_add_outlined),
                color: kSecondaryColor,
              )
            ],
          ),

          // child: BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
          // ),
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
