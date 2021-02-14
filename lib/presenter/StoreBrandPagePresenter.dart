import 'package:flutter_kata/kata.dart';
import 'package:naturalhome/viewable/StoreBrandPageViewable.dart';

class StoreBrandPagePresenter extends BaseListPresenter<StoreBrandPageViewable>{
  List designerList = [];
  StoreBrandPagePresenter(BaseListViewable viewable) : super(viewable);

  @override
  Future onLoadDataHttpRequest() {
    Map<String, dynamic> paramas = new Map();
    paramas["page"] = getPage();
    paramas["pageSize"] = getPageSize();
    //可选，设置了getTagName()的话，会绑定生命周期来自动取消请求
    return HttpManager.instance.get(url: "getBrandList", params: paramas, tag: getTagName());
  }

  onLoadDesignerList(){
    onCallHttpRequest(HttpManager.instance.get(url: "getDesignerList", tag: getTagName()), HttpCallback(
      onHttpSuccessCallback: (data, msg){
        viewable.onDesignerListSuccess(data, msg);
      }
    ));
  }

}