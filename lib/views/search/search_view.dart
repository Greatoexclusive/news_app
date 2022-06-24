import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/constants/apiKeys.dart';
import 'package:news_app/core/constants/imageKeys.dart';
import 'package:news_app/utils/all_functions.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/widgets/headline_skeleton.dart';
import 'package:news_app/widgets/headline_widget.dart';
import 'package:news_app/views/news/news_view.dart';
import 'package:news_app/views/search/components/searchbar.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchView extends StatefulWidget {
  const SearchView({Key? key, this.q}) : super(key: key);
  final String? q;
  @override
  State<SearchView> createState() => _SearchViewState();
}

final AllFunction _allFunction = AllFunction();

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    // _allFunction.trendingList = [];
    // _allFunction.searchNewsList = [];
    Future.delayed(const Duration(milliseconds: 200), () => init());

    super.initState();
  }

  init() async {
    if (_allFunction.trendingList.isEmpty) {
      await _allFunction.getTrendingAndLatest();
    }
    if (widget.q != null) await _allFunction.getSearchNews(widget.q);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              // snap: true,
              backgroundColor: kPrimaryColor,
              leading: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: widget.q != null
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                        )
                      : Container(
                          clipBehavior: Clip.hardEdge,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: CachedNetworkImage(
                            imageUrl: ImageKeys.profileImage,
                          ),
                        ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchBar(
                                    text: widget.q == null ? "" : widget.q!,
                                  )));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          color: kPrimaryLightColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20)),
                      width: MediaQuery.of(context).size.width - 135,
                      child: Row(
                        children: [
                          AppText.captionMedium(widget.q == null
                              ? "Search myNEWZ"
                              : '"${widget.q!}"'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 5),
            ),
            const SliverToBoxAdapter(
                child: Divider(
              thickness: 2,
            )),
            SliverPinnedHeader(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                    color: kPrimaryColor,
                    child: AppText.headingMeduim(widget.q == null
                        ? "Trending & Latest on myNEWZ"
                        : 'Search result for "${widget.q!}"'))),
            SliverToBoxAdapter(
              child: Column(children: [
                ...List.generate(
                  widget.q == null
                      ? _allFunction.trendingList.isNotEmpty
                          ? _allFunction.trendingList.length
                          : 5
                      : _allFunction.searchNewsList.isNotEmpty
                          ? _allFunction.searchNewsList.length
                          : 5,
                  (index) => widget.q != null
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsView(
                                          link:
                                              _allFunction.searchNewsList[index]
                                                  [ApiKeys.link],
                                          handle:
                                              _allFunction.searchNewsList[index]
                                                  [ApiKeys.handle],
                                          body:
                                              _allFunction.searchNewsList[index]
                                                  [ApiKeys.body],
                                          time: timeago.format(DateTime.parse(
                                              _allFunction.trendingList[index]
                                                  [ApiKeys.time])),
                                          rights:
                                              _allFunction.searchNewsList[index]
                                                  [ApiKeys.rights],
                                          topic:
                                              _allFunction.searchNewsList[index]
                                                  [ApiKeys.topic],
                                          title:
                                              _allFunction.searchNewsList[index]
                                                  [ApiKeys.title],
                                          image: _allFunction
                                                          .searchNewsList[index]
                                                      [ApiKeys.image] ==
                                                  ApiKeys.emptyString
                                              ? ImageKeys.noImage
                                              : _allFunction
                                                          .searchNewsList[index]
                                                      [ApiKeys.image] ??
                                                  ImageKeys.noImage,
                                        )));
                          },
                          child: _allFunction.trendingList.isEmpty
                              ? const HeadlineSkeletonCard()
                              : HeadlineCard(
                                  handle: _allFunction.searchNewsList[index]
                                      [ApiKeys.handle] ??= "",
                                  body: _allFunction.trendingList[index]
                                      [ApiKeys.body],
                                  time: timeago.format(DateTime.parse(
                                      _allFunction.trendingList[index]
                                          [ApiKeys.time])),
                                  rights: _allFunction.searchNewsList[index]
                                      [ApiKeys.rights],
                                  topic: _allFunction.searchNewsList[index]
                                      [ApiKeys.topic],
                                  title: _allFunction.searchNewsList[index]
                                      [ApiKeys.title],
                                  image: _allFunction.searchNewsList[index]
                                              [ApiKeys.image] ==
                                          ApiKeys.emptyString
                                      ? ImageKeys.noImage
                                      : _allFunction.searchNewsList[index]
                                              [ApiKeys.image] ??
                                          ImageKeys.noImage,
                                ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsView(
                                          link: _allFunction.trendingList[index]
                                              [ApiKeys.link],
                                          handle:
                                              _allFunction.trendingList[index]
                                                  [ApiKeys.handle],
                                          body: _allFunction.trendingList[index]
                                              [ApiKeys.body],
                                          time: timeago.format(DateTime.parse(
                                              _allFunction.trendingList[index]
                                                  [ApiKeys.time])),
                                          rights:
                                              _allFunction.trendingList[index]
                                                  [ApiKeys.rights],
                                          topic:
                                              _allFunction.trendingList[index]
                                                  [ApiKeys.topic],
                                          title:
                                              _allFunction.trendingList[index]
                                                  [ApiKeys.title],
                                          image: _allFunction
                                                          .searchNewsList[index]
                                                      [ApiKeys.image] ==
                                                  ApiKeys.emptyString
                                              ? ImageKeys.noImage
                                              : _allFunction
                                                          .searchNewsList[index]
                                                      [ApiKeys.image] ??
                                                  ImageKeys.noImage,
                                        )));
                          },
                          child: _allFunction.trendingList.isEmpty
                              ? const HeadlineSkeletonCard()
                              : HeadlineCard(
                                  handle: _allFunction.trendingList[index]
                                      [ApiKeys.handle] ??= "",
                                  body: _allFunction.trendingList[index]
                                      [ApiKeys.body],
                                  time: timeago.format(DateTime.parse(
                                      _allFunction.trendingList[index]
                                          [ApiKeys.time])),
                                  rights: _allFunction.trendingList[index]
                                      [ApiKeys.rights],
                                  topic: _allFunction.trendingList[index]
                                      [ApiKeys.topic],
                                  title: _allFunction.trendingList[index]
                                      [ApiKeys.title],
                                  image: _allFunction.trendingList[index]
                                              [ApiKeys.image] ==
                                          ApiKeys.emptyString
                                      ? ImageKeys.noImage
                                      : _allFunction.trendingList[index]
                                              [ApiKeys.image] ??
                                          ImageKeys.noImage,
                                ),
                        ),
                )
              ]),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.headingMeduim(
                    "Getting more feeds",
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    height: 15,
                    width: 15,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: kSecondaryColor,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
