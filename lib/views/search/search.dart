import 'package:flutter/material.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:news_app/widgets/healine_widget.dart';
import 'package:news_app/views/news/news_view.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Container(
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
                              builder: ((context) => Scaffold())));
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
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.white,
                              size: 20,
                            )),
                        hintText: "Search",
                        hintStyle: TextStyle(
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
            ),
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
