import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_kata/kata.dart';
import 'package:naturalhome/presenter/ProductRecommendedPresenter.dart';
import 'package:naturalhome/widgetpage/BaseCommonListPage.dart';

class ProductRecommendedPage extends StatefulWidget {
  final String title;

  ProductRecommendedPage(
      {Key key, this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductRecommendedState();
  }
}
/// 没有其他需要回调的，无需定义自己的viewable直接用BaseListViewable也可以,默认是BaseListViewable不需要implements也可以
class ProductRecommendedState extends BaseCommonListPage<
    ProductRecommendedPage,
    ProductRecommendedPresenter> implements BaseListViewable {

  @override
  void initState() {
    title = widget.title;
    super.initState();
  }
  @override
  returnBindingPresenter() {
    return ProductRecommendedPresenter(this);
  }
}
