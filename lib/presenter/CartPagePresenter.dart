import 'package:flutter_kata/kata.dart';
import 'package:naturalhome/viewable/CartPageViewable.dart';

class CartPagePresenter extends BaseListPresenter<CartPageViewable>{
  CartPagePresenter(BaseListViewable viewable) : super(viewable);

  @override
  Future onLoadDataHttpRequest() {
    return HttpManager.instance.get(url: "getCartList", tag: getTagName());
  }

  void onPay() {
    Map<String, dynamic> paramas = new Map();
    paramas["cart"] = "数据";
    onCallHttpRequest(HttpManager.instance.post(url: "payTheCart", params: paramas, tag: getTagName()), HttpCallback(
      onHttpSuccessCallback: (data, msg){
        viewable.onPaySuccess(data, msg);
      },
      onHttpFailCallback: (code, msg, [data]){
        viewable.onPayFailed(code, msg, data);
      },
        onNetWorkErrorCallback: (msg){
        viewable.onPayFailed(-1, msg);
      }
    ));
  }
}