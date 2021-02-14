import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_kata/kata.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:naturalhome/adapter/CartItemWidget.dart';
import 'package:naturalhome/constants/ColorConstants.dart';
import 'package:naturalhome/constants/ValueConstants.dart';
import 'package:naturalhome/manager/DeviceManager.dart';
import 'package:naturalhome/model/CartItemModel.dart';
import 'package:naturalhome/presenter/CartPagePresenter.dart';
import 'package:naturalhome/viewable/CartPageViewable.dart';
import 'package:naturalhome/widgetview/TwoSidesAppBar.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CartPageState();
  }
}

class CartPageState extends BaseListWidgetState<CartPage, CartPagePresenter>  with  AutomaticKeepAliveClientMixin
    implements CartPageViewable {
  @override
  bool get wantKeepAlive => true;//切换界面不重新绘制

  EasyRefreshController _controller;
  PageState _pageState = PageState.normal;
  double bottomToolHeight = 60;
  double price = 0;

  @override
  void initState() {
    _controller = EasyRefreshController();
    super.initState();
    presenter.onLoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf7f8fd),
      appBar: TwoSidesAppBar(
        title: "ShoppingCart",
      ),
      body: Column(
        children: [
          Expanded(child: EasyRefresh.custom(
            controller: _controller,
            header: null,
            footer: null,
            emptyWidget: _getStateWidget(),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
//                    CartItemModel item =
//                    CartItemModel.fromJson(presenter.dataList[index]);
                    return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: CartItemWidget(map: presenter.dataList[index], viewable: this),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            color: Colors.transparent,
                            iconWidget: SvgPicture.asset(
                              "assets/svg/ic_cart_delete.svg",
                              color: Color(0xFFFF4848),
                              width: 32,
                              height: 32,
                            ),
                            onTap: () {
                              setState(() {
                                presenter.dataList.removeAt(index);
                              });
                              onTotalPriceChange();
                            },
                          ),
                        ]);
                  },
                  childCount: presenter.dataList.length,
                ),
              ),
            ],
          )),
          Container(
            color: Colors.white,
            height: 50,
            child:
            Container(
              padding: EdgeInsets.only(left: 20),
              width: DeviceManager.instance.screenWidth,
              height: bottomToolHeight,
              color: Colors.white,
              child: Row(
                children: [
                  Text("total:",
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: kTextLightColor, fontSize: 16)),
                  Container(width: 5,),
                  Expanded(
                      flex: 1,
                      child: Text("\$${price}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: kYellowLightColor, fontSize: 18))),
                  SizedBox(
                    width: 150,
                    height: bottomToolHeight,
                    child: FlatButton(
                      onPressed: () {
                        onPay();
                      },
                      child: Hero(
                          tag: "Pay",
                          child: Text(
                            "Pay",
                            style: TextStyle(fontSize: 18),
                          )),
                      color: kPrimaryColor,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            )
            ,
          )
        ],
      ),
    );
  }

  @override
  returnBindingPresenter() {
    return CartPagePresenter(this);
  }

  Widget _getStateWidget() {
    switch (_pageState) {
      case PageState.empty:
        return Container(
          child: Center(
            child: Image.asset("assets/images/ic_pagestate_empty.png"),
          ),
        );
      case PageState.error:
        return Container(
          child: Center(
            child: Image.asset("assets/images/ic_pagestate_error.png"),
          ),
        );
      default:
        return null;
    }
  }

  @override
  onCountChange() {
    onTotalPriceChange();
  }

  onLoadComplete(){
    onTotalPriceChange();
  }

  onTotalPriceChange(){
    price = 0;
    for (var item in presenter.dataList){
      CartItemModel cartItemModel = CartItemModel.fromJson(item);
      price = price + cartItemModel.count * double.parse(cartItemModel.product.price);
    }
    setState(() {
    });
  }

  onPay(){
    presenter.onPay();
  }

  @override
  onPayFailed(int code, String msg, [data]) {
    Fluttertoast.showToast(msg: msg);
  }

  @override
  onPaySuccess(data, String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
