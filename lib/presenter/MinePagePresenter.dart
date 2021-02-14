import 'package:flutter_kata/kata.dart';
import 'package:naturalhome/model/UserInfoModel.dart';

class MinePagePresenter extends BaseDetailPresenter{
  //登录后的用户信息应该是单例保存，这里只是演示
  UserInfoModel userInfo;
  MinePagePresenter(BaseDataViewable viewable) : super(viewable);

  @override
  Future onLoadDataHttpRequest() {
    Map<String, dynamic> paramas = new Map();
    return HttpManager.instance.get(url: "getMyInfo", tag: getTagName());
  }


}