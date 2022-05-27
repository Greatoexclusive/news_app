import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_app/utils/all_functions.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/views/bookmark/bookmark_view.dart';
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
  var random = Random();

  late int randomNumber = random.nextInt(10);

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
      const Duration(seconds: 2),
      () => init(
        tabsList[selectedIndex],
      ),
    );

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
                enableArrowBack: false,
                isDisabled: false,
                icon: Icons.bookmark,
                title: "myNEWZ",
                onTap: () {
                  print(_allFunction.bookmarkList);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => BookmarkView(
                          bookmarkList: _allFunction.bookmarkList)),
                    ),
                  );
                },
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
                              handle: _allFunction.newsList[randomNumber]
                                  ["twitter_account"],
                              body: _allFunction.newsList[randomNumber]
                                  ["summary"],
                              topic: _allFunction.newsList[randomNumber]
                                  ["topic"],
                              title: _allFunction.newsList[randomNumber]
                                  ["title"],
                              image: _allFunction.newsList[randomNumber]
                                  ["media"],
                              time: timeago.format(DateTime.parse(_allFunction
                                  .newsList[randomNumber]["published_date"])),
                              rights: _allFunction.newsList[randomNumber]
                                  ["rights"],
                            ),
                          ),
                        );
                      },
                      child: _allFunction.newsList.isEmpty
                          ? const FirstNewsSkeleton()
                          : FirstNewsCard(
                              topic: _allFunction.newsList[randomNumber]
                                  ["topic"],
                              title: _allFunction.newsList[randomNumber]
                                  ["title"],
                              image: _allFunction.newsList[randomNumber]
                                  ["media"],
                              time: timeago.format(DateTime.parse(_allFunction
                                  .newsList[randomNumber]["published_date"])),
                              rights: _allFunction.newsList[randomNumber]
                                  ["rights"],
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
                                  randomNumber = random
                                      .nextInt(_allFunction.newsList.length);
                                  setState(() {});
                                  _allFunction.newsList.clear();
                                  Future.delayed(const Duration(seconds: 1),
                                      () => init(tabsList[selectedIndex]));
                                },
                                child: Tabs(
                                  color: index == selectedIndex
                                      ? kSecondaryColor
                                      : kPrimaryColor.withOpacity(0.5),
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
                              : _allFunction.newsList.length,
                          (index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsView(
                                            handle: _allFunction.newsList[index]
                                                ["twitter_account"],
                                            body: _allFunction.newsList[index]
                                                ["summary"],
                                            time: timeago.format(DateTime.parse(
                                                _allFunction.newsList[index]
                                                    ["published_date"])),
                                            rights: _allFunction.newsList[index]
                                                ["rights"],
                                            topic: _allFunction.newsList[index]
                                                ["topic"],
                                            title: _allFunction.newsList[index]
                                                ["title"],
                                            image: _allFunction.newsList[index]
                                                ["media"],
                                          )));
                            },
                            child: _allFunction.newsList.isEmpty
                                ? const HeadlineSkeletonCard()
                                : HeadlineCard(
                                    onPressed: () {
                                      final snack = SnackBar(
                                        backgroundColor: kSecondaryColor,
                                        elevation: 5,
                                        duration: const Duration(seconds: 1),
                                        content: AppText.headingMeduim(
                                            "Bookmarked!"),
                                        // action: SnackBarAction(
                                        //   label: "Undo",
                                        //   onPressed: () {},
                                        // ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snack);
                                      _allFunction.addBookmark({
                                        "title": _allFunction.newsList[index]
                                            ["title"],
                                        "topic": _allFunction.newsList[index]
                                            ["topic"],
                                        "image": _allFunction.newsList[index]
                                            ["media"],
                                        "time": timeago.format(DateTime.parse(
                                            _allFunction.newsList[index]
                                                ["published_date"])),
                                        "rights": _allFunction.newsList[index]
                                            ["rights"],
                                        "body": _allFunction.newsList[index]
                                            ["summary"],
                                        "handle": _allFunction.newsList[index]
                                            ["twitter_account"] ??= "",
                                      });
                                    },
                                    handle: _allFunction.newsList[index]
                                        ["twitter_account"] ??= "",
                                    body: _allFunction.newsList[index]
                                        ["summary"],
                                    time: timeago.format(DateTime.parse(
                                        _allFunction.newsList[index]
                                            ["published_date"])),
                                    rights: _allFunction.newsList[index]
                                        ["rights"],
                                    topic: _allFunction.newsList[index]
                                        ["topic"],
                                    title: _allFunction.newsList[index]
                                        ["title"],
                                    image: _allFunction.newsList[index]
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
      ),
    );
  }
}
