import 'package:flutter/material.dart';
import 'package:news_app/utils/all_functions.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/widgets/headline_widget.dart';
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
          CustomAppBar(
            enableArrowBack: true,
            isDisabled: false,
            title: "Bookmarks",
            icon: Icons.delete_outline,
            onTap: () {
              if (widget.bookmarkList.isEmpty) {
                final snack = SnackBar(
                  backgroundColor: kSecondaryColor,
                  elevation: 5,
                  duration: const Duration(seconds: 4),
                  content: AppText.headingMeduim(
                      "You currently do not have any bookmarks!"),
                );
                ScaffoldMessenger.of(context).showSnackBar(snack);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: kPrimaryColor,
                    title: const Center(
                        child: Icon(
                      Icons.warning,
                      size: 50,
                      color: kSecondaryColor,
                    )),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: AppText.headingMeduim("Clear bookmark?"),
                        )
                      ],
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kSecondaryColor, // Background color
                            ),
                            autofocus: true,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                          // Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kSecondaryColor, // Background color
                            ),
                            autofocus: true,
                            onPressed: () {
                              widget.bookmarkList.clear();
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          widget.bookmarkList.isEmpty
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
                            onPressed: () {
                              Map<String, dynamic> removedItem =
                                  widget.bookmarkList[index];
                              widget.bookmarkList
                                  .remove(widget.bookmarkList[index]);
                              setState(() {});
                              final snack = SnackBar(
                                backgroundColor: kSecondaryColor,
                                elevation: 5,
                                duration: const Duration(seconds: 4),
                                content: AppText.headingMeduim("Unbookmarked!"),
                                action: SnackBarAction(
                                  label: "Undo",
                                  onPressed: () {
                                    widget.bookmarkList.add(removedItem);
                                    setState(() {});
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snack);
                            },
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
