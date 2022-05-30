import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_app/core/constants/apiKeys.dart';
import 'package:news_app/core/constants/imageKeys.dart';
import 'package:news_app/utils/all_functions.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/views/bookmark/bookmark_view.dart';
import 'package:news_app/views/home/components/bottomLoading.dart';
import 'package:news_app/views/home/components/first_news_card.dart';
import 'package:news_app/views/home/components/first_news_card_skeleton.dart';
import 'package:news_app/widgets/headline_skeleton.dart';
import 'package:news_app/widgets/headline_widget.dart';
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

  int selectedIndex = 0;
  int prevSelectedIndex = 0;
  var random = Random();
  ScrollController scrollController = ScrollController();
  late int randomNumber = random.nextInt(_allFunction.newsList.length);
  String title = "myNews";
  String bookMarkedMessage = "Bookmarked!";

  List<String> tabsList = [
    "Politics",
    "Business",
    "Sports",
    "Entertainment",
    "Travel",
    "Music",
    "Public",
    "Tech"
  ];

  @override
  void initState() {
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            _allFunction.newsList.isNotEmpty) {
          print("i want more");
          Future.delayed(
            const Duration(seconds: 2),
            () => initGetMore(
              tabsList[selectedIndex],
            ),
          );
          setState(() {});
          print("i have more");
        }
      },
    );
    if (_allFunction.newsList.isEmpty) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => init(
          tabsList[selectedIndex],
        ),
      );
    }

    super.initState();
  }

  init(q) async {
    await _allFunction.getNews(q);
    setState(() {});
  }

  initGetMore(q) async {
    _allFunction.getMoreNews(tabsList[selectedIndex]);
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
                title: title,
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
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {
                        if (_allFunction.newsList.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsView(
                                handle: _allFunction.newsList[randomNumber]
                                    [ApiKeys.handle],
                                body: _allFunction.newsList[randomNumber]
                                    [ApiKeys.body],
                                topic: _allFunction.newsList[randomNumber]
                                    [ApiKeys.topic],
                                title: _allFunction.newsList[randomNumber]
                                    [ApiKeys.title],
                                image: _allFunction.newsList[randomNumber]
                                            [ApiKeys.image] ==
                                        ApiKeys.emptyString
                                    ? ImageKeys.noImage
                                    : _allFunction.newsList[randomNumber]
                                            [ApiKeys.image] ??
                                        ImageKeys.noImage,
                                time: timeago.format(DateTime.parse(_allFunction
                                    .newsList[randomNumber][ApiKeys.time])),
                                rights: _allFunction.newsList[randomNumber]
                                    [ApiKeys.rights],
                              ),
                            ),
                          );
                        }
                      },
                      child: _allFunction.newsList.isEmpty
                          ? const FirstNewsSkeleton()
                          : FirstNewsCard(
                              topic: _allFunction.newsList[randomNumber]
                                  [ApiKeys.topic],
                              title: _allFunction.newsList[randomNumber]
                                  [ApiKeys.title],
                              image: _allFunction.newsList[randomNumber]
                                          [ApiKeys.image] ==
                                      ApiKeys.emptyString
                                  ? ImageKeys.noImage
                                  : _allFunction.newsList[randomNumber]
                                          [ApiKeys.image] ??
                                      ImageKeys.noImage,
                              time: timeago.format(DateTime.parse(_allFunction
                                  .newsList[randomNumber][ApiKeys.time])),
                              rights: _allFunction.newsList[randomNumber]
                                  [ApiKeys.rights],
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
                                  if (_allFunction.newsList.isNotEmpty) {
                                    prevSelectedIndex = selectedIndex;
                                    selectedIndex = index;
                                    randomNumber = random
                                        .nextInt(_allFunction.newsList.length);
                                    setState(() {});
                                    if (selectedIndex != prevSelectedIndex) {
                                      _allFunction.newsList.clear();
                                      Future.delayed(const Duration(seconds: 1),
                                          () => init(tabsList[selectedIndex]));
                                    }
                                  }
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
                              if (_allFunction.newsList.isNotEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsView(
                                              handle:
                                                  _allFunction.newsList[index]
                                                      [ApiKeys.handle],
                                              body: _allFunction.newsList[index]
                                                  [ApiKeys.body],
                                              time: timeago.format(
                                                  DateTime.parse(_allFunction
                                                          .newsList[index]
                                                      [ApiKeys.time])),
                                              rights:
                                                  _allFunction.newsList[index]
                                                      [ApiKeys.rights],
                                              topic:
                                                  _allFunction.newsList[index]
                                                      [ApiKeys.topic],
                                              title:
                                                  _allFunction.newsList[index]
                                                      [ApiKeys.title],
                                              image: _allFunction
                                                              .newsList[index]
                                                          [ApiKeys.image] ==
                                                      ApiKeys.emptyString
                                                  ? ImageKeys.noImage
                                                  : _allFunction.newsList[index]
                                                          [ApiKeys.image] ??
                                                      ImageKeys.noImage,
                                            )));
                              }
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
                                            bookMarkedMessage),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snack);
                                      _allFunction.addBookmark({
                                        ApiKeys.title: _allFunction
                                            .newsList[index][ApiKeys.title],
                                        ApiKeys.topic: _allFunction
                                            .newsList[index][ApiKeys.topic],
                                        ApiKeys.image:
                                            _allFunction.newsList[index]
                                                        [ApiKeys.image] ==
                                                    ApiKeys.emptyString
                                                ? ImageKeys.noImage
                                                : _allFunction.newsList[index]
                                                        [ApiKeys.image] ??
                                                    ImageKeys.noImage,
                                        ApiKeys.time: timeago.format(
                                            DateTime.parse(
                                                _allFunction.newsList[index]
                                                    [ApiKeys.time])),
                                        ApiKeys.time: _allFunction
                                            .newsList[index][ApiKeys.rights],
                                        ApiKeys.body: _allFunction
                                            .newsList[index][ApiKeys.body],
                                        ApiKeys.handle:
                                            _allFunction.newsList[index]
                                                    [ApiKeys.handle] ??=
                                                ApiKeys.emptyString,
                                      });
                                    },
                                    handle: _allFunction.newsList[index]
                                            [ApiKeys.handle] ??=
                                        ApiKeys.emptyString,
                                    body: _allFunction.newsList[index]
                                        [ApiKeys.body] ??= ApiKeys.emptyString,
                                    time: timeago.format(DateTime.parse(
                                        _allFunction.newsList[index]
                                            [ApiKeys.time])),
                                    rights: _allFunction.newsList[index]
                                            [ApiKeys.rights] ??=
                                        ApiKeys.emptyString,
                                    topic: _allFunction.newsList[index]
                                        [ApiKeys.topic],
                                    title: _allFunction.newsList[index]
                                        [ApiKeys.title],
                                    image: _allFunction.newsList[index]
                                                [ApiKeys.image] ==
                                            ApiKeys.emptyString
                                        ? ImageKeys.noImage
                                        : _allFunction.newsList[index]
                                                [ApiKeys.image] ??
                                            ImageKeys.noImage,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_allFunction.newsList.isNotEmpty)
                    const SliverToBoxAdapter(child: BottomLoading())
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
