import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_kata/presenter/BaseListPresenter.dart';
import 'package:flutter_kata/widget/BaseListWidegetState.dart';
import 'package:naturalhome/adapter/ListAdapter.dart';
import 'package:naturalhome/constants/ValueConstants.dart';
import 'package:naturalhome/model/ProductModel.dart';
import 'package:naturalhome/widgetview/TwoSidesAppBar.dart';

import 'ProductDetailPage.dart';

abstract class BaseCommonListPage<W extends StatefulWidget, P extends BaseListPresenter> extends BaseListWidgetState<W, P>{
  EasyRefreshController _controller;
  PageState _pageState = PageState.normal;
  String title;
  @override
  void initState() {
    _controller = EasyRefreshController();
    super.initState();
    presenter.onLoadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TwoSidesAppBar(
        title: title,
        goBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: EasyRefresh.custom(
        controller: _controller,
        header: ClassicalHeader(),
        footer: ClassicalFooter(),
        emptyWidget: _getStateWidget(),
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        onRefresh: () async {
          presenter.onLoadData();
        },
        onLoad: () async {
          presenter.onLoadMore();
        },
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return ListAdapter.getRecommendListItemWidget(
                    ProductModel.fromJson(presenter.dataList[index]),
                    _onProductBuyClick,
                    _onProductDetailClick);
              },
              childCount: presenter.dataList.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onDataSetChange(data, String msg) {
    super.onDataSetChange(data, msg);
    setState(() {
      _pageState = PageState.normal;
    });
  }
  @override
  void onStatusEmpty(String msg) {
    super.onStatusEmpty(msg);
    setState(() {
      _pageState = PageState.empty;
    });
  }

  @override
  void onStatusError(int code, String msg, data) {
    super.onStatusError(code, msg, data);
    setState(() {
      _pageState = PageState.error;
    });
  }

  @override
  void onLoadComplete() {
    super.onLoadComplete();
    _controller.finishRefresh();
    _controller.finishLoad(noMore: !presenter.isHasMore);
  }

  /// 点击购买按钮
  _onProductBuyClick(ProductModel item) {}

  /// 点击去产品详情
  _onProductDetailClick(ProductModel item) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ProductDetailWidget(productId: item.id, coverUrl: item.cover)));
  }

  Widget _getStateWidget() {
    switch(_pageState){
      case PageState.empty:
        return Container(
          child: Center(
            child: Image.asset("assets/images/ic_pagestate_empty.png"),
          ),
        );
      case PageState.error:
        return Container(
          child: Center(
            child: Image.asset("assets/images/ic_pagestate_error.png"),
          ),
        );
      default:
        return null;
    }
  }

}