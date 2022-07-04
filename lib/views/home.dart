import 'package:flutter/material.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/views/bookmark/bookmark_view.dart';
import 'package:news_app/views/home/home_view.dart';
import 'package:news_app/views/search/search_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeViewState();
}

int _selectedPage = 0;
PageController _pageController = PageController();

class _HomeViewState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    onPageChange(int index) {
      setState(() {
        _selectedPage = index;
      });
      _pageController.jumpToPage(index);
    }

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: PageView(
          onPageChanged: onPageChange,
          controller: _pageController,
          children: [
            const HomeView(),
            const SearchView(),
            BookmarkView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kPrimaryColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: kPrimaryColor,
              icon: Icon(
                Icons.home,
                size: 25,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              backgroundColor: kPrimaryColor,
              icon: Icon(
                Icons.search,
                size: 25,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              backgroundColor: kPrimaryColor,
              icon: Icon(
                Icons.favorite,
                size: 25,
              ),
              label: "",
            ),
          ],
          currentIndex: _selectedPage,
          selectedItemColor: kSecondaryColor,
          unselectedItemColor: Colors.grey,
          onTap: onPageChange,
        ),
      ),
    );
  }
}
