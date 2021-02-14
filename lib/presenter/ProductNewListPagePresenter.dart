import 'package:flutter_kata/kata.dart';

class ProductNewListPagePresenter extends BaseListPresenter{

  int pageSize = 8;//覆盖父类默认的20
  ProductNewListPagePresenter(BaseListViewable viewable) : super(viewable);

  @override
  Future onLoadDataHttpRequest() {
    Map<String, dynamic> paramas = new Map();
    paramas["page"] = getPage();
    paramas["pageSize"] = getPageSize();
    //可选，设置了getTagName()的话，会绑定生命周期来自动取消请求
    return HttpManager.instance.get(url: "getNewProductList", params: paramas, tag: getTagName());
  }

}