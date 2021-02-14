import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_kata/kata.dart';
import 'package:naturalhome/constants/ColorConstants.dart';
import 'package:naturalhome/manager/ImageManager.dart';
import 'package:naturalhome/model/UserInfoModel.dart';
import 'package:naturalhome/presenter/MinePagePresenter.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'MineBoughtPage.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends BaseDataWidgetState<MinePage, MinePagePresenter>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; //切换界面不重新绘制

  // Tab控制器
  TabController _tabController;
  List<String> _tabNames = ["Bought", "Pending", "Unpaid"];

  // 初始化
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabNames.length, vsync: this);
    presenter.onLoadData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: extended.NestedScrollView(
        pinnedHeaderSliverHeightBuilder: () {
          return MediaQuery.of(context).padding.top + kToolbarHeight;
        },
        innerScrollPositionKeyBuilder: () {
          return Key(_tabNames[_tabController.index]);
        },
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: Text("My information"),
              leading: IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                iconSize: 24,
              ),
              actions: [
                IconButton(
                    icon: Image.asset(
                      "assets/images/ic_topbar_customerservice.png",
                      width: 24,
                      height: 24,
                    ),
                    onPressed: _onOpenCustomerService())
              ],
              centerTitle: true,
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Image.asset(
                      "assets/images/bg_topbar_mine.jpg",
                      fit: BoxFit.fitHeight,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    //色彩遮罩
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Color(0x993e536e),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 100),
                          padding: EdgeInsets.all(5),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          child: ClipOval(
                            child:
                            presenter.userInfo == null ?Container():ImageManager.load(presenter.userInfo?.avatar, 95, 95),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Text(
                            presenter.userInfo?.name ?? "",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  presenter.userInfo?.spend ?? "0",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Container(
                                  height: 5,
                                ),
                                Text(
                                  "Spend",
                                  style: TextStyle(
                                      color: Color(0xFFbfc9d5), fontSize: 16),
                                ),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  presenter.userInfo?.alreadybuy ?? "0",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Container(
                                  height: 5,
                                ),
                                Text(
                                  "Alread buy",
                                  style: TextStyle(
                                      color: Color(0xFFbfc9d5), fontSize: 16),
                                ),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  presenter.userInfo?.collection ?? "0",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Container(
                                  height: 5,
                                ),
                                Text(
                                  "Collection",
                                  style: TextStyle(
                                      color: Color(0xFFbfc9d5), fontSize: 16),
                                ),
                              ],
                            )),
                          ],
                        ))
                      ],
                    )
                  ],
                ),
                stretchModes: [StretchMode.zoomBackground],
              ),
              floating: false,
              pinned: true,
            ),
          ];
        },
        body: _getTabWidget(),
      ),
    );
  }

  @override
  returnBindingPresenter() {
    return MinePagePresenter(this);
  }

  Widget _getTabWidget() {
    return ContainedTabBarView(
      tabBarProperties: TabBarProperties(
          background: Container(
            color: Colors.white,
          ),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: kPrimaryColor,
          labelColor: kPrimaryColor,
          unselectedLabelColor: kPrimaryLightColor,
          height: 52),
      tabs: [Text(_tabNames[0]), Text(_tabNames[1]), Text(_tabNames[2])],
      views: [
        extended.NestedScrollViewInnerScrollPositionKeyWidget(
          Key(_tabNames[0]),
          MineBoughtPage(),
        ),
        extended.NestedScrollViewInnerScrollPositionKeyWidget(
          Key(_tabNames[1]),
          Container(),
        ),
        extended.NestedScrollViewInnerScrollPositionKeyWidget(
          Key(_tabNames[2]),
          Container(),
        ),
      ],
      onChange: (index) => print(index),
    );
  }

  _onOpenCustomerService() {}

  @override
  void onDataSetChange(data, String msg) {
    super.onDataSetChange(data, msg);
    setState(() {
      presenter.userInfo = UserInfoModel.fromJson(data);
    });
  }
}
