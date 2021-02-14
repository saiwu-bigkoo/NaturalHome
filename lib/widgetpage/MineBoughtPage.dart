import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_kata/widget/BaseListWidegetState.dart';
import 'package:naturalhome/adapter/ListAdapter.dart';
import 'package:naturalhome/constants/ValueConstants.dart';
import 'package:naturalhome/model/ProductModel.dart';
import 'package:naturalhome/presenter/MineBoughtPagePresenter.dart';

class MineBoughtPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MineBoughtPageState();
  }
}

class MineBoughtPageState extends BaseListWidgetState<MineBoughtPage, MineBoughtPagePresenter> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true; //切换界面不重新绘制

  EasyRefreshController _controller;
  PageState _pageState = PageState.normal;
  @override
  void initState() {
    _controller = EasyRefreshController();
    super.initState();
    presenter.onLoadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return ListAdapter.getBoughtListItemWidget(
                    ProductModel.fromJson(presenter.dataList[index]),
                    );
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

  @override
  returnBindingPresenter() {
    return MineBoughtPagePresenter(this);
  }

}