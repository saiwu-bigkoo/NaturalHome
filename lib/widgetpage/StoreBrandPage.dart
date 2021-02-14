import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_kata/kata.dart';
import 'package:naturalhome/adapter/ListAdapter.dart';
import 'package:naturalhome/model/BrandModel.dart';
import 'package:naturalhome/model/DesignerModel.dart';
import 'package:naturalhome/presenter/StoreBrandPagePresenter.dart';
import 'package:naturalhome/viewable/StoreBrandPageViewable.dart';

class StoreBrandPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StoreBrandPageState();
  }
}

class StoreBrandPageState
    extends BaseListWidgetState<StoreBrandPage, StoreBrandPagePresenter>
    implements StoreBrandPageViewable {




  EasyRefreshController _controller;
  int headerCount = 0;

  @override
  void initState() {
    _controller = EasyRefreshController();
    super.initState();
    presenter.onLoadData();
    presenter.onLoadDesignerList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xFFf7f8fd),
      child: _getListWidget(),
    );
  }

  @override
  returnBindingPresenter() {
    return StoreBrandPagePresenter(this);
  }

  Widget _getListWidget() {
    EasyRefresh widget = EasyRefresh.custom(
      controller: _controller,
      header: ClassicalHeader(),
      footer: null,
      enableControlFinishRefresh: true,
      onRefresh: () async {
        presenter.onLoadData();
        presenter.onLoadDesignerList();
      },
      bottomBouncing: false,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              //已经完成了加载新品模块则index变为新品模块
              if (headerCount == 1 && index == 0) {
                return _getDesignerWidget();
              }
              BrandModel item =
                  BrandModel.fromJson(presenter.dataList[index - headerCount]);

              /// 品牌item
              return ListAdapter.getBandListItemWidget(item);
            },
            childCount: presenter.dataList.length + headerCount,
          ),
        ),
      ],
    );

    return widget;
  }

  /// 设计师模块
  Widget _getDesignerWidget() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: presenter.designerList.length,
          itemBuilder: (BuildContext context, int index) {
            /// 设计师item
            return ListAdapter.getDesignerItemWidget(DesignerModel.fromJson(presenter.designerList[index]));
          }),
    );
  }
  @override
  onDesignerListSuccess(data, String msg) {
    presenter.designerList = data;
    setState(() {
      headerCount = 1;
    });
  }

  @override
  void onLoadComplete() {
    super.onLoadComplete();
    _controller.finishRefresh();
  }
}
