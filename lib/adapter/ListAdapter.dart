import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naturalhome/constants/ColorConstants.dart';
import 'package:naturalhome/manager/ImageManager.dart';
import 'package:naturalhome/model/BrandModel.dart';
import 'package:naturalhome/model/CartItemModel.dart';
import 'package:naturalhome/model/DesignerModel.dart';
import 'package:naturalhome/model/ProductModel.dart';
import 'dart:math' as math;

import 'package:naturalhome/viewable/CartPageViewable.dart';

typedef OnProductBuyClick = void Function(ProductModel item);
typedef OnProductDetailClick = void Function(ProductModel item);

class ListAdapter {
  /// 首页-新品模块Item NewProduct Item
  static Widget getHomeNewProductListItemWidget(ProductModel item) {
    return Card(
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
        width: 200,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            ImageManager.load(item.cover, 84, 84),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text("${item.name}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(color: kPrimaryColor, fontSize: 16))),
                  Text("\$${item.price}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: kYellowLightColor, fontSize: 16))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  static Widget getRecommendListItemWidget(
      ProductModel item,
      OnProductBuyClick onProductBuyClick,
      OnProductDetailClick onProductDetailClick) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 150,
      padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5),
      child: GestureDetector(
        onTap: () {
          onProductDetailClick(item);
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
                    Hero(
                        tag: item.cover,
                        child: ImageManager.load(item.cover, 120, 120)),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${item.name}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: kPrimaryColor, fontSize: 18)),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text("${item.description}",
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
                                  child: Text("\$${item.price}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: kYellowLightColor,
                                          fontSize: 18))),
                              SizedBox(
                                height: 24,
                                width: 60,
                                child: FlatButton(
                                    onPressed: () {
                                      onProductBuyClick(item);
                                    },
                                    child: Text("Buy"),
                                    color: kPrimaryColor,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              )
                            ],
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
              child: getRecommendListItemHotTagWidget(item.tag),
            )
          ],
        ),
      ),
    );
  }

  static Widget getRecommendListItemHotTagWidget(String tag) {
    if (tag != null && tag.isNotEmpty) {
      return Container(
        width: 36,
        height: 36,
        margin: EdgeInsets.only(top: 2, right: 2),
        child: Stack(
          children: [
            Image.asset("assets/images/bg_itemtag_righttop.png"),
            Positioned(
                top: 7,
                left: 6,
                child: Transform.rotate(
                    angle: math.pi / 4,
                    child: Text(tag,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))))
          ],
        ),
      );
    }
    return Container(
      width: 0,
      height: 0,
    );
  }

  /// 首页 store - brand 列表
  static Widget getBandListItemWidget(BrandModel item) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5),
      child: GestureDetector(
        onTap: () {},
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
                child: Column(children: [
                  ImageManager.load(item.cover, double.infinity, 150),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    height: 80,
                    child: Row(
                      children: [
                        ClipOval(
                          child: ImageManager.load(item.avatar, 64, 64),
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("${item.name}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 18)),
                              Container(
                                height: 5,
                              ),
                              Text("${item.description}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: kPrimaryLightColor, fontSize: 14))
                            ],
                          ),
                        )),
                        Column(
                          children: [
                            Container(
                              height: 5,
                            ),
                            Text("\$${item.score}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: kYellowLightColor, fontSize: 18)),
                            Container(
                              height: 10,
                            ),
                            SizedBox(
                              height: 24,
                              width: 60,
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Text("Like"),
                                  color: kPrimaryColor,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
            Positioned(
              right: 0,
              child: getRecommendListItemHotTagWidget(item.tag),
            )
          ],
        ),
      ),
    );
  }

  static Widget getDesignerItemWidget(DesignerModel item) {
    return Container(
      width: 130,
      padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
      child: GestureDetector(
        onTap: () {},
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: ImageManager.load(item.avatar, 54, 54),
                    ),
                    Container(
                      height: 5,
                    ),
                    Text("${item.name}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: kPrimaryColor, fontSize: 16)),
                    Container(
                      height: 3,
                    ),
                    Text("${item.description}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: kPrimaryLightColor, fontSize: 12)),
                    Container(
                      height: 10,
                    ),
                    SizedBox(
                        height: 24,
                        width: 65,
                        child: FlatButton(
                            onPressed: () {},
                            child: Text("View"),
                            color: kPrimaryColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))))
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: getRecommendListItemHotTagWidget(item.tag),
            )
          ],
        ),
      ),
    );
  }

  static Widget getBoughtListItemWidget(
      ProductModel item) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5),
      child: GestureDetector(
        onTap: () {},
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
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 104,
                      child: Row(
                        children: [
                          ImageManager.load(item.cover, 80, 80),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${item.name}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: kPrimaryColor, fontSize: 18)),
                                Expanded(
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        child: Text("${item.description}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: kPrimaryLightColor,
                                                fontSize: 14)))),
                                Text("\$${item.price}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: kYellowLightColor, fontSize: 18))
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    Container(
                      color: kDividerColor,
                      height: 1,
                      width: double.infinity,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          child: FlatButton.icon(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            icon: Image.asset(
                              "assets/images/ic_review.png",
                              fit: BoxFit.contain,
                              width: 16,
                              height: 16,
                            ),
                            label: Text(
                              "Review",
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFFacb8c4)),
                            ),
                          ),
                        ),
                        Container(
                          color: kDividerColor,
                          height: double.infinity,
                          width: 1,
                        ),
                        Expanded(
                          child: FlatButton.icon(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            icon: Image.asset(
                              "assets/images/ic_logistics.png",
                              fit: BoxFit.contain,
                              width: 16,
                              height: 16,
                            ),
                            label: Text(
                              "Logistics",
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFFacb8c4)),
                            ),
                          ),
                        ),
                        Container(
                          color: kDividerColor,
                          height: double.infinity,
                          width: 1,
                        ),
                        Expanded(
                          child: FlatButton.icon(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            icon: Image.asset(
                              "assets/images/ic_more.png",
                              fit: BoxFit.contain,
                              width: 16,
                              height: 16,
                            ),
                            label: Text(
                              "More",
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFFacb8c4)),
                            ),
                            onPressed: (){
                            }
                          ),
                        ),
                        Container(
                          color: kDividerColor,
                          height: double.infinity,
                          width: 1,
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: getRecommendListItemHotTagWidget(item.tag),
            )
          ],
        ),
      ),
    );
  }
}
