import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kata/kata.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:naturalhome/constants/ColorConstants.dart';
import 'package:naturalhome/constants/ValueConstants.dart';
import 'package:naturalhome/manager/DeviceManager.dart';
import 'package:naturalhome/manager/ImageManager.dart';
import 'package:naturalhome/model/ProductModel.dart';
import 'package:naturalhome/presenter/ProductDetailPresenter.dart';
import 'package:naturalhome/viewable/ProductDetailViewable.dart';
import 'package:naturalhome/widgetview/AlphaAppBar.dart';

import 'ProductPropertyBottomSheet.dart';

class ProductDetailWidget extends StatefulWidget {
  final String productId;
  final String coverUrl;

  ProductDetailWidget(
      {Key key, @required this.productId, @required this.coverUrl})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ProductDetailWidgetState();
  }
}

class ProductDetailWidgetState
    extends BaseDataWidgetState<ProductDetailWidget, ProductDetailPresenter>
    implements ProductDetailViewable {
  double coverHeight;
  double bottomToolHeight = 60;
  ScrollController _scrollController;
  bool isFavourite = false;

  @override
  void initState() {
    coverHeight = DeviceManager.instance.screenWidth;
    _scrollController = ScrollController();
    super.initState();
    presenter.onLoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
              tag: presenter.coverUrl,
              child: ImageManager.load(presenter.coverUrl,
                  DeviceManager.instance.screenWidth, coverHeight)),
          Container(
            margin: EdgeInsets.only(bottom: bottomToolHeight),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(top: coverHeight),
              child: Container(
                alignment: Alignment.topLeft,
                width: DeviceManager.instance.screenWidth,
                //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Colors.white, // 底色
                    borderRadius:
                        new BorderRadius.vertical(top: Radius.circular(20))),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("${presenter.data?.name}",
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 18))),
                    Container(
                      alignment: Alignment.topLeft,
                      constraints: BoxConstraints(minHeight: 800),
                      margin: EdgeInsets.only(top: 15),
                      child: Text("${presenter.data?.description}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: kPrimaryLightColor, fontSize: 14)),
                    )
                  ],
                ),
              ),
            ),
          ),
          AlphaAppBar(
            height: appbarHeight,
            alphaHeight: coverHeight,
            themeColor: kPrimaryColor,
            scrollController: _scrollController,
            goBack: () {
              Navigator.of(context).pop();
            },
          ),
          Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 20),
                width: DeviceManager.instance.screenWidth,
                height: bottomToolHeight,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text("\$${presenter.data?.price}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: kYellowLightColor, fontSize: 18))),
                    Container(
                      width: 1,
                      height: bottomToolHeight,
                      color: kDividerColor,
                    ),
                    SizedBox(
                      width: 80,
                      child: FlatButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/ic_addtocart.png",
                              width: 25,
                              height: 25,
                              fit: BoxFit.contain,
                            ),
                            Container(
                              height: 3,
                            ),
                            Hero(
                                tag: "Add To Cart",
                                child: Text(
                                  "Add To Cart",
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 8.0),
                                ))
                          ],
                        ),
                        onPressed: () {
                          showCupertinoModalBottomSheet(
                            expand: false,
                            context: context,
                            backgroundColor: Colors.white,
                            builder: (context) => ProductPropertyBottomSheet(
                                product: presenter.data, action: "Add To Cart"),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: bottomToolHeight,
                      child: FlatButton(
                        onPressed: () {
                          showCupertinoModalBottomSheet(
                            expand: false,
                            context: context,
                            backgroundColor: Colors.white,
                            builder: (context) => ProductPropertyBottomSheet(
                              product: presenter.data,
                              action: "Buy",
                            ),
                          );
                        },
                        child: Hero(
                            tag: "Buy",
                            child: Text(
                              "Buy",
                              style: TextStyle(fontSize: 18),
                            )),
                        color: kPrimaryColor,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: 64,
                  decoration: BoxDecoration(
                    color: isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
                    boxShadow: [BoxShadow(color: Color(0x30000000))],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: SvgPicture.asset(
                    "assets/svg/favourite.svg",
                    color: isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                    height: 16,
                  ),
                ),
                onTap: () {
                  setState(() {
                    isFavourite = !isFavourite;
                  });
                },
              ))
        ],
      ),
    );
  }

  @override
  returnBindingPresenter() {
    return ProductDetailPresenter(this, widget.productId, widget.coverUrl);
  }

  @override
  void onDataSetChange(data, String msg) {
    super.onDataSetChange(data, msg);
    setState(() {
      presenter.data = ProductModel.fromJson(data);
    });
  }
}
