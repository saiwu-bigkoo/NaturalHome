import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kata/kata.dart';
import 'package:naturalhome/widgetpage/CartPage.dart';
import 'package:naturalhome/widgetpage/HomePage.dart';
import 'package:naturalhome/widgetpage/StorePage.dart';

import 'TestData.dart';
import 'constants/ColorConstants.dart';
import 'manager/DeviceManager.dart';
import 'widgetpage/MinePage.dart';

void main() {
  runApp(MyApp());
  statusBar(true);
  HttpManager.instance.setBaseUrl("https://api.kata.com/");
  TestData.test();
}

/// 沉浸式状态栏 这里吧，感觉flutter支持得很不好，如果在其他页面切换状态栏颜色切换时有明显卡顿
statusBar(bool isLight) {
  // 白色沉浸式状态栏颜色  白色文字
  SystemUiOverlayStyle light = SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarDividerColor: null,

    /// 注意安卓要想实现沉浸式的状态栏 需要底部设置透明色
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: isLight?Brightness.light:Brightness.dark,
    statusBarIconBrightness: isLight?Brightness.light:Brightness.dark,
    statusBarBrightness: isLight?Brightness.dark:Brightness.light,
  );
  SystemChrome.setSystemUIOverlayStyle(light);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
        primaryColor: kPrimaryColor,
          ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //这里用了PageView+BottomNavigationBar，子页面AutomaticKeepAliveClientMixin方案实现切换页面不重绘
  var _pages = [
    HomePageWidget(),
    StorePage(),
    CartPage(),
    MinePage(),
  ];
  int _tabIndex = 0;

  var _pageController =PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceManager.getInstance().init(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),//禁止页面左右滑动切换
          controller: _pageController,
          onPageChanged: _pageChanged,//回调函数
          itemCount: _pages.length,
          itemBuilder: (context,index)=>_pages[index]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shopcart',
          ),
          BottomNavigationBarItem(
            icon: _getBottomNavigationBarImage("icon_my"),
            activeIcon: _getBottomNavigationBarImage('icon_my_selected'),
            label: 'My',
          )
        ],
        currentIndex: _tabIndex,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kPrimaryLightColor,
        onTap: (index){
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  Widget _getBottomNavigationBarImage(String iconName) {
    return Image.asset(
      'assets/images/${iconName}.png', // 在项目中添加图片文件夹
      width: 24,
      height: 24,
    );
  }

  void _pageChanged(int index){
    setState(() {
      if(_tabIndex != index)
        _tabIndex = index;
    });
  }
}
