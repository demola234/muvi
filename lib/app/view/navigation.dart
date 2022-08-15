import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moviex/core/shared/image_path.dart';

import '../../core/utils/customs/customs_configs.dart';
import '../../features/movies/presentation/bookmark/views/bookmark.dart';
import '../../features/movies/presentation/movies/views/movies.dart';
import '../../features/movies/presentation/search/views/search_screen.dart';

class NavController extends StatefulWidget {
  const NavController({Key? key}) : super(key: key);

  @override
  _NavControllerState createState() => _NavControllerState();
}

class _NavControllerState extends State<NavController> {
  late PageController pageController;
  int _page = 0;

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        body: PageView(
          children: [
            Movies(),
            SearchScreen(),
            MyWidget(),
          ],
          onPageChanged: onPageChanged,
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white.withOpacity(0.2),
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(MuviAssets.video,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: Colors.grey),
                  YMargin(9.0),
                ],
              ),
              label: "",
              tooltip: "Dashboard",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    MuviAssets.video,
                    height: 20,
                    width: 20,
                    allowDrawingOutsideViewBox: true,
                    color: !isDarkMode ? Color(0xFFFECD00) : Colors.white,
                  ),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !isDarkMode ? Colors.white : Color(0xFFFECD00)),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(MuviAssets.shape,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: Colors.grey),
                  YMargin(9.0),
                ],
              ),
              label: "",
              tooltip: "Posts",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(MuviAssets.shape,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: !isDarkMode ? Color(0xFFFECD00) : Colors.white),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !isDarkMode ? Colors.white : Color(0xFFFECD00)),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(MuviAssets.shape,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: Colors.grey),
                  YMargin(9.0),
                ],
              ),
              label: "",
              tooltip: "Posts",
              activeIcon: Column(
                children: [
                  SvgPicture.asset(MuviAssets.shape,
                      height: 20,
                      width: 20,
                      allowDrawingOutsideViewBox: true,
                      color: !isDarkMode ? Color(0xFFFECD00) : Colors.white),
                  YMargin(4.0),
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !isDarkMode ? Colors.white : Color(0xFFFECD00)),
                  )
                ],
              ),
            ),
          ],
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: navigationTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: _page,
          iconSize: 20,
        ));
  }
}
