import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naturalhome/constants/ColorConstants.dart';
import 'package:naturalhome/manager/DeviceManager.dart';

import 'StoreBrandPage.dart';

class StorePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StorePageState();
  }

}
class StorePageState extends State<StorePage> with  AutomaticKeepAliveClientMixin{
  final double statusBarDistanceFactor = 5.0; //距离因子，topbar与状态栏的距离
  final double topbarHeight = 56.0;
  @override
  bool get wantKeepAlive => true;//切换界面不重新绘制

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: Stack(children: [

          //内容
          Container(
            color: Colors.white,
            width: DeviceManager.instance.screenWidth,
            padding: EdgeInsets.only(
                top: DeviceManager.getInstance().statusBarHeight +
                    topbarHeight +
                    statusBarDistanceFactor * 2),
            child: ContainedTabBarView(
              tabBarProperties: TabBarProperties(
                  indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: kPrimaryColor,
                  labelColor: kPrimaryColor,
                  unselectedLabelColor: kPrimaryLightColor,
                  height: 30
              ),
              tabs: [
                Text('brand'),
                Text('person'),
                Text('shops')
              ],
              views: [
                StoreBrandPage(),
                Container(color: Colors.green),
                Container(color: Colors.orange),
              ],
              onChange: (index) => print(index),
            )
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                top: DeviceManager.getInstance().statusBarHeight +
                    statusBarDistanceFactor),
            child: _getTopBarWidget(),
          ),
        ]),
      ),
    );
  }

  ///顶部搜索栏
  Widget _getTopBarWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        new Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 15, top: 8, bottom: 8),
              child: DecoratedBox(
                  decoration: BoxDecoration(
//                border: new Border.all(color: Color(0x80FFFFFF), width: 0.5), // 边色与边宽度
                    color: Color(0xFFf6f6fe), // 底色
                    borderRadius: BorderRadius.circular(5.0), //3像素圆角
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/ic_textflied_search_light.png",
                            width: 24,
                            height: 24,
                            fit: BoxFit.scaleDown,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(top: 18),
                                alignment: Alignment.center,
                                constraints: BoxConstraints(
                                  maxHeight: 38,
                                ),
                                child: TextField(
                                    maxLines: 1,
                                    autofocus: false,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: kPrimaryColor), //文字大小、颜色
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: "Search the product",
                                      hintStyle:
                                      TextStyle(color: kPrimaryColor), //修改颜色
//                                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                    )),
                              ))
                        ],
                      ))),
            )),
        IconButton(
            icon: Image.asset(
              "assets/images/ic_topbar_customerservice_light.png",
              width: 24,
              height: 24,
            ),
            onPressed: _onOpenCustomerService())
      ],
    );
  }

  _onOpenCustomerService() {}

}