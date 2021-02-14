import 'package:flutter/widgets.dart';
import 'package:flutter_kata/viewable/BaseListViewable.dart';
import 'package:flutter_kata/widget/BaseListWidegetState.dart';
import 'package:naturalhome/presenter/ProductNewListPagePresenter.dart';
import 'package:naturalhome/widgetpage/BaseCommonListPage.dart';

///新品列表
class ProductNewListPage extends StatefulWidget {
  final String title;

  ProductNewListPage(
      {Key key, this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductNewListPageState();
  }
}

class ProductNewListPageState extends BaseCommonListPage<
    ProductNewListPage,
    ProductNewListPagePresenter> implements BaseListViewable {

  @override
  void initState() {
    title = widget.title;
    super.initState();
  }

  @override
  returnBindingPresenter() {
    return ProductNewListPagePresenter(this);
  }
}