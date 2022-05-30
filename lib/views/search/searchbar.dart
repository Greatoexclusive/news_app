import 'package:flutter/material.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/views/search/search_view.dart';
import 'package:news_app/widgets/headline_widget.dart';
import 'package:news_app/views/news/news_view.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key? key, this.text}) : super(key: key);

  final String? text;
  @override
  State<SearchBar> createState() => _SearchState();
}

class _SearchState extends State<SearchBar> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = widget.text!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor.withOpacity(0.2),
                ),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  onSubmitted: (value) {
                    value = _controller.text;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => SearchView(
                              q: value,
                            )),
                      ),
                    );
                  },
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                      prefixIcon: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                            size: 20,
                          )),
                      hintText: "Search",
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        // fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none),
                ),
              ),
              // GestureDetector(
              //   onTap: () {},
              //   child: const Icon(
              //     Icons.more_vert,
              //     color: Colors.white,
              //     size: 30,
              //   ),
              // )
            ],
          )),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: AppText.captionMedium("Recent searches"),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5)
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: kPrimaryColor,
    ));
  }
}
