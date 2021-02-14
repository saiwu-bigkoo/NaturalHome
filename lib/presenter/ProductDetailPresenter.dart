import 'package:flutter_kata/kata.dart';
import 'package:naturalhome/model/ProductModel.dart';
import 'package:naturalhome/viewable/ProductDetailViewable.dart';

class ProductDetailPresenter extends BaseDetailPresenter<ProductDetailViewable>{
  String productId;
  String coverUrl;
  ProductModel data;
  ProductDetailPresenter(BaseDataViewable viewable, this.productId, this.coverUrl) : super(viewable);

  @override
  Future onLoadDataHttpRequest() {
    Map<String, dynamic> paramas = new Map();
    paramas["id"] = productId;
    return HttpManager.instance.get(url: "getProductDetail", params: paramas, tag: getTagName());
  }

}