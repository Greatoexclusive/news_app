import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/apiKeys.dart';
import 'package:news_app/utils/all_functions.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/views/news/components/news_image_card.dart';
import 'package:news_app/views/webview/explore_webview.dart';

class NewsView extends StatefulWidget {
  NewsView({
    Key? key,
    required this.title,
    required this.topic,
    required this.image,
    required this.time,
    required this.rights,
    required this.body,
    required this.handle,
    required this.link,
    this.bookmarked,
  }) : super(key: key);
  final String title;
  final String topic;
  final String image;
  final String time;
  final String rights;
  final String body;
  final String handle;
  final String link;

  bool? bookmarked;

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  void initState() {
    widget.bookmarked = widget.bookmarked == null ? false : widget.bookmarked;
    super.initState();
  }

  var selectedIndex = 0;
  var random = Random();
  late int viewCount = random.nextInt(10000);
  late int likeCount = random.nextInt(5000);

  final Map<String, dynamic> bookmarkedItem = {};
  bool followed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewsImageCard(
                  likeCount: likeCount,
                  viewCount: viewCount,
                  onPressedBookmark: () {
                    widget.bookmarked = !widget.bookmarked!;
                    if (widget.bookmarked!) {
                      likeCount = likeCount + 1;
                    } else {
                      likeCount = likeCount - 1;
                    }

                    bookmarkedItem[ApiKeys.title] = widget.title;
                    bookmarkedItem[ApiKeys.link] = widget.link;

                    bookmarkedItem[ApiKeys.body] = widget.body;
                    bookmarkedItem[ApiKeys.handle] = widget.handle;
                    bookmarkedItem[ApiKeys.image] = widget.image;
                    bookmarkedItem[ApiKeys.rights] = widget.rights;
                    bookmarkedItem[ApiKeys.topic] = widget.topic;
                    bookmarkedItem[ApiKeys.time] = widget.time;
                    if (widget.bookmarked!) {
                      AllFunction.addBookmark(bookmarkedItem);
                    } else {
                      AllFunction.removeBookmark(bookmarkedItem);
                    }
                    setState(() {});
                  },
                  bookmarked: widget.bookmarked!,
                  onPressedBack: () {
                    Navigator.pop(context);
                  },
                  time: widget.time,
                  topic: widget.topic,
                  title: widget.title,
                  image: widget.image),
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
                        AppText.headingMeduim(widget.rights),
                        AppText.captionMedium(widget.handle)
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          followed = !followed;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Icon(
                              followed ? Icons.check : Icons.add,
                              color: Colors.white,
                              size: 15,
                            ),
                            AppText.captionMedium(
                              followed ? "  Unfollow" : "Follow",
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: followed ? kPrimaryColor : kSecondaryColor,
                          border: Border.all(
                            color: kSecondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AppText.captionMedium(widget.body),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                          ExploreWebview(url: widget.link))));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: kSecondaryColor,
                  border: Border.all(
                    color: kSecondaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.headingMeduim(
                      "Explore",
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.explore,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: kPrimaryColor,
    );
  }
}
