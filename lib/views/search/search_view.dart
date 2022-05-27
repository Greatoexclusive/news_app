import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/widgets/healine_widget.dart';
import 'package:news_app/views/news/news_view.dart';
import 'package:news_app/views/search/search.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                  ),
                ),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Search()));
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                        color: kPrimaryLightColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)),
                    width: MediaQuery.of(context).size.width - 135,
                    child: Row(
                      children: [
                        AppText.captionMedium(
                          "Search myNEWZ",
                        ),
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
          SliverToBoxAdapter(
            child: SizedBox(height: 5),
          ),
          SliverToBoxAdapter(
              child: const Divider(
            thickness: 2,
          )),
          SliverPinnedHeader(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  color: kPrimaryColor,
                  child: AppText.headingMeduim("Trending on myNEWZ"))),
          SliverToBoxAdapter(
              child: Column(children: [
            // ...List.generate(
            //   15,
            //   (index) => GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const NewsView(),
            //         ),
            //       );
            //     },
            //     child: const HeadlineCard(
            //       image:
            //           "https://images.pexels.com/photos/1633406/pexels-photo-1633406.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
            //     ),
            //   ),
            // )
          ]))
        ],
      ),
      backgroundColor: kPrimaryColor,
    ));
  }
}
