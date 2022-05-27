import 'package:flutter/material.dart';
import 'package:news_app/utils/all_functions.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/views/home/components/first_news_card.dart';
import 'package:news_app/widgets/healine_widget.dart';
import 'package:news_app/views/home/components/tabs.dart';
import 'package:news_app/views/news/news_view.dart';
import 'package:news_app/widgets/custom_appbar.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({Key? key}) : super(key: key);

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

AllFunction _allFunction = AllFunction();

class _BookmarkViewState extends State<BookmarkView> {
  @override
  void initState() {
    _allFunction.getBookmarkLocally();
    setState(() {
      print(_allFunction.bookmarkList);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            isDisabled: false,
            title: "Bookmark",
            icon: Icons.delete_outline,
            onTap: () {
              setState(() {});
            },
          ),
          Expanded(
            child: ListView(
              children: [
                ...List.generate(
                  _allFunction.bookmarkList.length,
                  (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsView(
                                    handle: _allFunction.bookmarkList[index]
                                        ["handle"],
                                    body: _allFunction.bookmarkList[index]
                                        ["body"],
                                    time: _allFunction.bookmarkList[index]
                                        ["time"],
                                    title: _allFunction.bookmarkList[index]
                                        ["title"],
                                    topic: _allFunction.bookmarkList[index]
                                        ["topic"],
                                    rights: _allFunction.bookmarkList[index]
                                        ["rights"],
                                    image: _allFunction.bookmarkList[index]
                                        ["image"],
                                  )));
                    },
                    child: HeadlineCard(
                      handle: _allFunction.bookmarkList[index]["handle"],
                      body: _allFunction.bookmarkList[index]["body"],
                      time: _allFunction.bookmarkList[index]["time"],
                      title: _allFunction.bookmarkList[index]["title"],
                      topic: _allFunction.bookmarkList[index]["topic"],
                      rights: _allFunction.bookmarkList[index]["rights"],
                      image: _allFunction.bookmarkList[index]["image"],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: kPrimaryColor,
    ));
  }
}
