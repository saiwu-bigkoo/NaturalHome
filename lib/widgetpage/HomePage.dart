import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_kata/widget/BaseListWidegetState.dart';
import 'package:naturalhome/adapter/ListAdapter.dart';
import 'package:naturalhome/constants/ColorConstants.dart';
import 'package:naturalhome/manager/DeviceManager.dart';
import 'package:naturalhome/model/ProductModel.dart';
import 'package:naturalhome/presenter/HomePageWidgetPresenter.dart';
import 'package:naturalhome/viewable/HomePageViewable.dart';
import 'package:naturalhome/widgetpage/ProductDetailPage.dart';
import 'package:naturalhome/widgetpage/ProductRecommendedPage.dart';

import 'ProductNewListPage.dart';

class HomePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageWidgetState();
  }
}

class HomePageWidgetState extends BaseListWidgetState<HomePageWidget, HomePagePresenter>
    with AfterLayoutMixin, AutomaticKeepAliveClientMixin
    implements HomePageViewable {
  @override
  bool get wantKeepAlive => true;//切换界面不重新绘制

  EasyRefreshController _controller;
  final double headerOriginalHeight = 300.0;
  double headerHeight = 300.0;
  final double topbarHeight = 56.0;
  final double statusBarDistanceFactor = 5.0; //距离因子，topbar与状态栏的距离
  double _offset = 0.0;
  final int newproductAlready =
      2; //加载完newproduct内容后headCount是2，然后 headCount = newproductAlready即可
  int headerCount = 1; // 内容列表额外的头部widget数量
  ScrollController _scrollController;


  @override
  void initState() {
    _controller = EasyRefreshController();
    _scrollController = ScrollController();

    super.initState();
    presenter.onLoadData();
    presenter.onLoadNewProduct();
  }

  /// 添加监听滑动
  _scrollListener() {
    _offset = _scrollController.offset;

    var headerNowHeight = _getHeaderHeight();
    // 判断高度是否持续发生变化，如果顶部高度到了最小之后再向上滑动高度已经不再变化，所以就不要重绘了，避免过多绘制造成严重卡顿
    if (headerHeight != headerNowHeight){
      setState(() {
        headerHeight = headerNowHeight;
      });
    }
  }

  double _getHeaderHeight() {
    if (_offset == null) return headerOriginalHeight;
    if (_offset <= 0) {
      return min(max((headerOriginalHeight - _offset), headerOriginalHeight), 500.0);
    } else {
      return max(
//          min((headerOriginalHeight - _offset), headerOriginalHeight),
          headerOriginalHeight,//用上面注释是上滑缩小图片，但是由于导致滚动有点卡顿所以不进行缩小了，所以现在写死了这个值
          DeviceManager.getInstance().statusBarHeight +
              topbarHeight +
              statusBarDistanceFactor * 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: Stack(children: [
          //背景图
          SizedBox(
            width: DeviceManager.getInstance().screenWidth,
            child: Container(
              color: Color(0x505a7495),
              child: Image.asset("assets/images/bg_homepage_top.jpg",
                  width: DeviceManager.getInstance().screenWidth,
                  height: headerHeight,
                  fit: BoxFit.cover),
            ),
          ),
          //色彩遮罩
          ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0x805a7495)),
            ),
          ),
          //列表内容
          Container(
            margin: EdgeInsets.only(
                top: DeviceManager.getInstance().statusBarHeight +
                    topbarHeight +
                    statusBarDistanceFactor * 2),
            child: _getListWidget(),
          ),
          Container(
            margin: EdgeInsets.only(
                top: DeviceManager.getInstance().statusBarHeight +
                    statusBarDistanceFactor),
            child: _getTopBarWidget(),
          ),
        ]),
      ),
    );
  }

  ///顶部搜索栏
  Widget _getTopBarWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        new Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 15, top: 8, bottom: 8),
              child: DecoratedBox(
                  decoration: BoxDecoration(
//                border: new Border.all(color: Color(0x80FFFFFF), width: 0.5), // 边色与边宽度
                    color: Color(0x80FFFFFF), // 底色
                    borderRadius: BorderRadius.circular(5.0), //3像素圆角
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/ic_textflied_search.png",
                            width: 24,
                            height: 24,
                            fit: BoxFit.scaleDown,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(top: 18),
                                alignment: Alignment.center,
                                constraints: BoxConstraints(
                                  maxHeight: 38,
                                ),
                                child: TextField(
                                    maxLines: 1,
                                    autofocus: false,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white), //文字大小、颜色
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: "Search the product",
                                      hintStyle:
                                          TextStyle(color: Colors.white), //修改颜色
//                                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                    )),
                              ))
                        ],
                      ))),
            )),
        IconButton(
            icon: Image.asset(
              "assets/images/ic_topbar_customerservice.png",
              width: 24,
              height: 24,
            ),
            onPressed: _onOpenCustomerService())
      ],
    );
  }

  Widget _getListWidget() {
    EasyRefresh widget = EasyRefresh.custom(
      controller: _controller,
      header: null,
      footer: null,
      bottomBouncing: false,
      scrollController: _scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == 0) {
                return Container(
                  width: DeviceManager.getInstance().screenWidth,
                  height: headerOriginalHeight -
                      topbarHeight -
                      DeviceManager.instance.statusBarHeight -
                      statusBarDistanceFactor * 2,
                  child: Center(
                    child: Image.asset(
                        "assets/images/ic_home_top_txt.png",
                        width: DeviceManager.getInstance().screenWidth,
                        fit: BoxFit.contain),
                  ),
                );
              }
              //已经完成了加载新品模块则index变为新品模块
              if (headerCount == newproductAlready && index == 1) {
                return _getNewProductWidget();
              }
              ProductModel item = ProductModel.fromJson(presenter.dataList[index - headerCount]);
              /// 底部推荐列表 Recommend List
              return  ListAdapter.getRecommendListItemWidget(item, _onProductBuyClick, _onProductDetailClick);
            },
            childCount: presenter.dataList.length + headerCount,
          ),
        ),
      ],
    );

    return widget;
  }

  /// 新品模块 NewProduct
  Widget _getNewProductWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // New Product Tag 新品模块标签
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, right: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Text("New Product",
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: kTextLightColor, fontSize: 16))),
                GestureDetector(
                  child: Row(
                    children: [
                      Text(
                        "more",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: kTextLightColor, fontSize: 12),
                      ),
                      Image.asset("assets/images/ic_more_arrow.png",
                          width: 24, fit: BoxFit.contain),
                    ],
                  ),
                  onTap: () {
                    _onOpenNewProductList();
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                itemCount: presenter.newProductList.length,
                itemBuilder: (BuildContext context, int index) {
                  /// 新品模块Item NewProduct Item
                  return ListAdapter.getHomeNewProductListItemWidget(ProductModel.fromJson(presenter.newProductList[index]));
                }),
          ),
          // The Recommended Tag 推荐模块标签
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 10, top: 0, right: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Text("The Recommended",
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: kTextLightColor, fontSize: 16))),
                GestureDetector(
                  child: Row(
                    children: [
                      Text(
                        "more",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: kTextLightColor, fontSize: 12),
                      ),
                      Image.asset("assets/images/ic_more_arrow.png",
                          width: 24, fit: BoxFit.contain),
                    ],
                  ),
                  onTap: () {
                    _onOpenRecommendList();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _onOpenCustomerService() {}

  @override
  returnBindingPresenter() {
    return HomePagePresenter(this);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _scrollController.addListener(_scrollListener);
  }

  @override
  onLoadNewProductSuccess() {
    // 加载新品模块成功
    setState(() {
      headerCount = newproductAlready;
    });
  }

  /// 去新品列表
  _onOpenNewProductList(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProductNewListPage(title: "New Product")));
  }

  /// 去推荐列表
  _onOpenRecommendList(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProductRecommendedPage(title: "The Recommended")));
  }

  /// 点击购买按钮
  _onProductBuyClick(ProductModel item){}

  /// 点击去产品详情
  _onProductDetailClick(ProductModel item){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProductDetailWidget(productId: item.id, coverUrl: item.cover)));
  }
}
