import 'package:flutter/material.dart';
import 'package:flutter_shizhan/config/string.dart';
import 'package:flutter_shizhan/page/discovery/discovery_page.dart';
import 'package:flutter_shizhan/page/home/home_page.dart';
import 'package:flutter_shizhan/page/hot/hot_page.dart';
import 'package:flutter_shizhan/page/mine/mine_page.dart';
import 'package:flutter_shizhan/utils/toast_util.dart';
import 'package:flutter_shizhan/viewmodel/tab_navigation_viewmodel.dart';
import 'package:flutter_shizhan/widget/provider_widget.dart';

//TODO 快捷键 stful
class TabNavigation extends StatefulWidget {
  const TabNavigation({Key key}) : super(key: key);

  @override
  _TabNavigation createState() => _TabNavigation();
}

class _TabNavigation extends State<TabNavigation> {
  //点击返回 时间
  DateTime lastTime;

  //主体 实战1
  Widget _currentBody = Container(color: Colors.blue);

  //导航位置 实战1
  int _currentIndex = 0;

  //pageview 需要PageController 实战2
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    //防止用户误碰
    return WillPopScope(
      onWillPop: _onWillPop, //两次确认退出app
      child: Scaffold(
        // body: _currentBody,//实战1
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            // Container(
            //   color: Colors.blue,
            // ),
            HomePage(),
            // Container(
            //   color: Colors.brown,
            // ),
            DiscoveryPage(),
            // Container(
            //   color: Colors.orange,
            // ),
            HotPage(),
            // Container(
            //   color: Colors.red,
            // ),
            MinePage(),
          ],
        ), //实战2
        //实战1
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: _currentIndex,
        //   type: BottomNavigationBarType.fixed,
        //   //导航样式 固定
        //   selectedItemColor: Color(0xff000000),
        //   //字体 选中颜色
        //   unselectedItemColor: Color(0xff9a9a9a),
        //   //字体 未选中颜色
        //   items: _items(),
        //   //导航
        //   onTap: _onTap, //点击 切换导航页
        // ),
        bottomNavigationBar: ProviderWidget<TabNavigationViewModel>(
          model: TabNavigationViewModel(),
          builder: (context, model, child) {
            return BottomNavigationBar(
              currentIndex: model.currentIndex,
              //导航样式 固定
              type: BottomNavigationBarType.fixed,
              //字体 选中颜色
              selectedItemColor: Color(0xff000000),
              //字体 未选中颜色
              unselectedItemColor: Color(0xff9a9a9a),
              items: _items(),
              //导航 点击
              onTap: (index) {
                if (model.currentIndex != index) {
                  _pageController.jumpToPage(index);
                  model.changeBottomTabIndex(index);
                }
              }, //点击 切换导航页
            );
          },
        ),
      ),
    );
  }

  //实战1
  _onTap(int index) {
    switch (index) {
      case 0:
        _currentBody = Container(
          color: Colors.blue,
        );
        break;
      case 1:
        _currentBody = Container(
          color: Colors.brown,
        );
        break;
      case 2:
        _currentBody = Container(
          color: Colors.orange,
        );
        break;
      case 3:
        _currentBody = Container(
          color: Colors.red,
        );
        break;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  List<BottomNavigationBarItem> _items() {
    return [
      _bottomItem(LeoString.home, 'images/ic_home_normal.png',
          'images/ic_home_selected.png'),
      _bottomItem(LeoString.discovery, 'images/ic_discovery_normal.png',
          'images/ic_discovery_selected.png'),
      _bottomItem(LeoString.hot, 'images/ic_hot_normal.png',
          'images/ic_hot_selected.png'),
      _bottomItem(LeoString.mine, 'images/ic_mine_normal.png',
          'images/ic_mine_selected.png'),
    ];
  }

  _bottomItem(String title, String normalIcon, String selectorIcon) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          normalIcon,
          width: 24,
          height: 24,
        ),
        activeIcon: Image.asset(
          selectorIcon,
          width: 24,
          height: 24,
        ),
        label: title);
  }

  Future<bool> _onWillPop() async {
    if (lastTime == null ||
        DateTime.now().difference(lastTime) > Duration(seconds: 2)) {
      lastTime = DateTime.now();
      LeoToast.showTip(LeoString.exit_tip);
      return false;
    } else {
      //自动出栈
      return true;
    }
  }
}
