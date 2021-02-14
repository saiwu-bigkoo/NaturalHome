import 'package:flutter_kata/kata.dart';
import 'package:naturalhome/viewable/HomePageViewable.dart';

class HomePagePresenter extends BaseListPresenter<HomePageViewable>{
  List newProductList = [];

  HomePagePresenter(BaseListViewable viewable) : super(viewable);

  @override
  Future onLoadDataHttpRequest() {
    Map<String, dynamic> paramas = new Map();
    paramas["page"] = getPage();
    paramas["pageSize"] = getPageSize();
    //可选，设置了getTagName()的话，会绑定生命周期来自动取消请求
    return HttpManager.instance.get(url: "getHomeRecommendList", params: paramas, tag: getTagName());
  }

  onLoadNewProduct(){
    Map<String, dynamic> paramas = new Map();
    paramas["page"] = getPage();
    paramas["pageSize"] = getPageSize();
    // 传入HttpCallback回调，通过viewable再回到给视图widget
    onCallHttpRequest(HttpManager.instance.get(url: "getHomeNewProductList", params: paramas, tag: getTagName()), HttpCallback(
      onHttpSuccessCallback: (dynamic result,String msg){
        newProductList.addAll(result);
        viewable.onLoadNewProductSuccess();
      }
    ));
  }

}