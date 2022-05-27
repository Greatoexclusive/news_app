import 'package:flutter/material.dart';
import 'package:news_app/utils/all_functions.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/widgets/healine_widget.dart';
import 'package:news_app/views/news/news_view.dart';
import 'package:news_app/widgets/custom_appbar.dart';

class BookmarkView extends StatefulWidget {
  BookmarkView({Key? key, required this.bookmarkList}) : super(key: key);

  List<Map<String, dynamic>> bookmarkList;

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

AllFunction _allFunction = AllFunction();

class _BookmarkViewState extends State<BookmarkView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              print(_allFunction.bookmarkList);
            },
            child: CustomAppBar(
              enableArrowBack: true,
              isDisabled: false,
              title: "Bookmark",
              icon: Icons.delete_outline,
              onTap: () {
                setState(() {});
              },
            ),
          ),
          _allFunction.bookmarkList.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: (MediaQuery.of(context).size.height / 2) - 70,
                    ),
                    Center(
                      child: AppText.heading(
                        "No bookmarks",
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              : Expanded(
                  child: ListView(
                    children: [
                      ...List.generate(
                        widget.bookmarkList.length,
                        (index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsView(
                                          handle: widget.bookmarkList[index]
                                              ["handle"],
                                          body: widget.bookmarkList[index]
                                              ["body"],
                                          time: widget.bookmarkList[index]
                                              ["time"],
                                          title: widget.bookmarkList[index]
                                              ["title"],
                                          topic: widget.bookmarkList[index]
                                              ["topic"],
                                          rights: widget.bookmarkList[index]
                                              ["rights"],
                                          image: widget.bookmarkList[index]
                                              ["image"],
                                        )));
                          },
                          child: HeadlineCard(
                            handle: widget.bookmarkList[index]["handle"],
                            body: widget.bookmarkList[index]["body"],
                            time: widget.bookmarkList[index]["time"],
                            title: widget.bookmarkList[index]["title"],
                            topic: widget.bookmarkList[index]["topic"],
                            rights: widget.bookmarkList[index]["rights"],
                            image: widget.bookmarkList[index]["image"],
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
