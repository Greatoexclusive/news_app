import 'package:flutter/material.dart';
import 'package:news_app/core/constants/apiKeys.dart';
import 'package:news_app/utils/all_functions.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/widgets/headline_widget.dart';
import 'package:news_app/views/news/news_view.dart';
import 'package:news_app/widgets/custom_appbar.dart';

class BookmarkView extends StatefulWidget {
  BookmarkView({
    Key? key,
  }) : super(key: key);

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

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
            enableArrowBack: false,
            isDisabled: false,
            title: "Favourites",
            icon: Icons.delete_outline,
            onTap: () {
              if (AllFunction.bookmarkList.isEmpty) {
                final snack = SnackBar(
                  backgroundColor: kSecondaryColor,
                  elevation: 5,
                  duration: const Duration(seconds: 4),
                  content: AppText.headingMeduim(
                      "You currently do not have any favourites!"),
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
                          child: AppText.headingMeduim("Clear favourites?"),
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
                            onPressed: () {
                              AllFunction.bookmarkList.clear();
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
          AllFunction.bookmarkList.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: (MediaQuery.of(context).size.height / 2) - 70,
                    ),
                    Center(
                      child: AppText.heading(
                        "No favourites",
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              : Expanded(
                  child: ListView(
                    children: [
                      ...List.generate(
                        AllFunction.bookmarkList.length,
                        (index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsView(
                                          bookmarked: true,
                                          link: AllFunction.bookmarkList[index]
                                              [ApiKeys.link],
                                          handle:
                                              AllFunction.bookmarkList[index]
                                                  [ApiKeys.handle],
                                          body: AllFunction.bookmarkList[index]
                                              [ApiKeys.body],
                                          time: AllFunction.bookmarkList[index]
                                              [ApiKeys.time],
                                          title: AllFunction.bookmarkList[index]
                                              [ApiKeys.title],
                                          topic: AllFunction.bookmarkList[index]
                                              [ApiKeys.topic],
                                          rights:
                                              AllFunction.bookmarkList[index]
                                                      [ApiKeys.rights] ??
                                                  "",
                                          image: AllFunction.bookmarkList[index]
                                              [ApiKeys.image],
                                        )));
                          },
                          child: HeadlineCard(
                            handle: AllFunction.bookmarkList[index]
                                [ApiKeys.handle],
                            body: AllFunction.bookmarkList[index][ApiKeys.body],
                            time: AllFunction.bookmarkList[index][ApiKeys.time],
                            title: AllFunction.bookmarkList[index]
                                [ApiKeys.title],
                            topic: AllFunction.bookmarkList[index]
                                [ApiKeys.topic],
                            rights: AllFunction.bookmarkList[index]
                                [ApiKeys.rights],
                            image: AllFunction.bookmarkList[index]
                                [ApiKeys.image],
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
