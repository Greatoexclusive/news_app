import 'package:flutter/material.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/views/news/components/news_image_card.dart';

class NewsView extends StatelessWidget {
  NewsView({
    Key? key,
    required this.title,
    required this.topic,
    required this.image,
    required this.time,
    required this.rights,
    required this.body,
    required this.handle,
  }) : super(key: key);
  final String title;
  final String topic;
  final String image;
  final String time;
  final String rights;
  final String body;
  final String handle;

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewsImageCard(
                  time: time, topic: topic, title: title, image: image),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.headingMeduim(rights),
                        AppText.captionMedium(handle)
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                          AppText.captionMedium(
                            "Follow",
                            color: Colors.white,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AppText.captionMedium(body),
              )
            ],
          ),
        ],
      ),
      backgroundColor: kPrimaryColor,
    );
  }
}
