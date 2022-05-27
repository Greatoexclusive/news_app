import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/utils/all_functions.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/views/home/components/first_news_card.dart';
import 'package:news_app/views/home/components/first_news_card_skeleton.dart';
import 'package:news_app/widgets/healine_skeleton.dart';
import 'package:news_app/widgets/healine_widget.dart';
import 'package:news_app/views/home/components/tabs.dart';
import 'package:news_app/views/news/news_view.dart';
import 'package:news_app/widgets/custom_appbar.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AllFunction _allFunction = AllFunction();

  var selectedIndex = 0;
  bool isLoading = true;
  var random = Random();

  List<String> tabsList = [
    "Politics",
    "Business",
    "Sports",
    "Entertainment",
    "Travel",
    "Music",
    "Public",
  ];

  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 2), () => init(tabsList[selectedIndex]));
    super.initState();
  }

  init(q) async {
    setState(() {});
    await _allFunction.getNews(q);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Center(
            child: CustomAppBar(
              isDisabled: true,
              title: "myNEWZ",
              onTap: () {},
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsView(
                                    handle: _allFunction.newsList[0]
                                        ["twitter_account"],
                                    body: _allFunction.newsList[0]["summary"],
                                    topic: _allFunction.newsList[0]["topic"],
                                    title: _allFunction.newsList[0]["title"],
                                    image: _allFunction
                                        .newsList[random.nextInt(10)]["media"],
                                    time: timeago.format(DateTime.parse(
                                        _allFunction.newsList[0]
                                            ["published_date"])),
                                    rights: _allFunction.newsList[0]["rights"],
                                  )));
                    },
                    child: _allFunction.newsList.isEmpty
                        ? const FirstNewsSkeleton()
                        : FirstNewsCard(
                            topic: _allFunction.newsList[0]["topic"],
                            title: _allFunction.newsList[0]["title"],
                            image: _allFunction.newsList[0]["media"],
                            time: timeago.format(DateTime.parse(
                                _allFunction.newsList[0]["published_date"])),
                            rights: _allFunction.newsList[0]["rights"],
                          ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverPinnedHeader(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    color: kPrimaryColor,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            tabsList.length,
                            (index) => GestureDetector(
                              onTap: () {
                                selectedIndex = index;
                                setState(() {});
                                _allFunction.newsList.clear();
                                Future.delayed(const Duration(seconds: 1),
                                    () => init(tabsList[selectedIndex]));
                              },
                              child: Tabs(
                                color: index == selectedIndex
                                    ? kSecondaryColor
                                    : kPrimaryColor.withOpacity(0.1),
                                text: tabsList[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ...List.generate(
                        _allFunction.newsList.isEmpty
                            ? 3
                            : _allFunction.newsList.length - 1,
                        (index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsView(
                                          handle:
                                              _allFunction.newsList[index + 1]
                                                  ["twitter_account"],
                                          body: _allFunction.newsList[index + 1]
                                              ["summary"],
                                          time: timeago.format(DateTime.parse(
                                              _allFunction.newsList[index + 1]
                                                  ["published_date"])),
                                          rights: _allFunction
                                              .newsList[index + 1]["rights"],
                                          topic: _allFunction
                                              .newsList[index + 1]["topic"],
                                          title: _allFunction
                                              .newsList[index + 1]["title"],
                                          image: _allFunction
                                              .newsList[index + 1]["media"],
                                        )));
                          },
                          child: _allFunction.newsList.isEmpty
                              ? HeadlineSkeletonCard()
                              : HeadlineCard(
                                  handle: _allFunction.newsList[index + 1]
                                      ["twitter_account"] ??= "",
                                  body: _allFunction.newsList[index + 1]
                                      ["summary"],
                                  time: timeago.format(DateTime.parse(
                                      _allFunction.newsList[index + 1]
                                          ["published_date"])),
                                  rights: _allFunction.newsList[index + 1]
                                      ["rights"],
                                  topic: _allFunction.newsList[index + 1]
                                      ["topic"],
                                  title: _allFunction.newsList[index + 1]
                                      ["title"],
                                  image: _allFunction.newsList[index + 1]
                                      ["media"],
                                ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      backgroundColor: kPrimaryColor,
    ));
  }
}
