import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naturalhome/adapter/ListAdapter.dart';
import 'package:naturalhome/constants/ColorConstants.dart';
import 'package:naturalhome/manager/ImageManager.dart';
import 'package:naturalhome/model/CartItemModel.dart';
import 'package:naturalhome/viewable/CartPageViewable.dart';

/// 由于item 需要把购物车产品数量进行加减，界面需要绑定变化，所以需要独立出来写一个statefulwidget
class  CartItemWidget extends StatefulWidget{
  Map map;
  final CartPageViewable viewable;

  CartItemWidget({Key key, this.map, this.viewable}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CartItemWidgetState();
  }

}

class CartItemWidgetState extends State<CartItemWidget>{
  CartItemModel cartItemModel;
  int count;

  @override
  void initState() {
    cartItemModel = CartItemModel.fromJson(widget.map);
    count = cartItemModel.count;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return getShoppingCartItemWidget(cartItemModel, widget.viewable);
  }


  Widget getShoppingCartItemWidget(CartItemModel cartItemModel, CartPageViewable viewable) {
    return Container(
      width: double.infinity,
      height: 150,
      padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 3),
      child: GestureDetector(
        onTap: () {
        },
        child: Stack(
          children: [
            Card(
              color: Colors.white,
              //z轴的高度，设置card的阴影
              elevation: 2.0,
              //设置shape，这里设置成了R角
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
              clipBehavior: Clip.antiAlias,
              semanticContainer: false,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    ImageManager.load(cartItemModel.product.cover, 120, 120),
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${cartItemModel.product.name}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 18)),
                              Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 5, bottom: 5),
                                      child: Text("${cartItemModel.colourName},${cartItemModel.size}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: kPrimaryLightColor,
                                              fontSize: 14)))),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text("\$${cartItemModel.product.price}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: kYellowLightColor,
                                              fontSize: 18))),
                                  Container(
                                      height: 50,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              if (count == 1) return;
                                              cartItemModel.count = count;
                                              setState(() {
                                                count = count - 1;
                                              });
                                              widget.map["count"] = count;
                                              viewable.onCountChange();
                                            },
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 30,
                                            child: Text("${count}",
                                                style:
                                                TextStyle(color: kPrimaryColor, fontSize: 16.0)),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              cartItemModel.count = count;
                                              setState(() {
                                                count = count + 1;
                                              });
                                              widget.map["count"] = count;
                                              viewable.onCountChange();
                                            },
                                          )
                                        ],
                                      ))                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: ListAdapter.getRecommendListItemHotTagWidget(cartItemModel.product.tag),
            )
          ],
        ),
      ),
    );
  }
}