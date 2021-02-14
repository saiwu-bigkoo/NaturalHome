import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naturalhome/constants/ColorConstants.dart';
import 'package:naturalhome/constants/HexColor.dart';
import 'package:naturalhome/manager/DeviceManager.dart';
import 'package:naturalhome/model/ProductModel.dart';

class ProductPropertyBottomSheet extends StatefulWidget {
  final ProductModel product;
  final String action;

  ProductPropertyBottomSheet({Key key, @required this.product, @required this.action})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductPropertyBottomSheetState();
  }
}

class ProductPropertyBottomSheetState
    extends State<ProductPropertyBottomSheet> {
  String color;
  String size;
  int quentity = 1;

  @override
  void initState() {
    super.initState();
    color = widget.product.colours[0];
    size = widget.product.size[0];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          height: 280,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
            Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      "Colour:",
                      style: TextStyle(fontSize: 16, color: kPrimaryColor),
                    )),
                Row(
                  children: _getColoursWidget(),
                )
              ],
            ),
          ),
          Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: Text("Size:",
                          style: TextStyle(
                              color: kPrimaryColor, fontSize: 16.0))),
                  Row(
                    children: _getSizeWidget(),
                  )
                ],
              )),
          Container(
              height: 50,
              child: Row(
                children: [
                  Text(
                    "Quentity:",
                    style: TextStyle(fontSize: 16, color: kPrimaryColor),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (quentity == 1) return;
                      setState(() {
                        quentity--;
                      });
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 30,
                    child: Text("${quentity}",
                        style:
                        TextStyle(color: kPrimaryColor, fontSize: 16.0)),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quentity++;
                      });
                    },
                  )
                ],
              )),
          Container(
            width: DeviceManager.instance.screenWidth,
            margin: EdgeInsets.all(20),
            child: Expanded(flex: 1,child: FlatButton(
                height: 48,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Hero(tag: widget.action,
                    child:Text(widget.action,style: TextStyle(fontSize: 18, color: Colors.white),)),
                color: kPrimaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            ),)
      ],
    ),)
    ,
    );
  }

  List<Widget> _getColoursWidget() {
    return List.generate(
        widget.product.colours?.length,
            (index) =>
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.all(2),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  // 底色
                  color: color == widget.product.colours[index]
                      ? kYellowLightColor
                      : Colors.transparent,
                  shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                ),
                child: Container(
                    decoration: BoxDecoration(
                      // 底色
                      color: HexColor.fromHex(widget.product.colours[index]),
                      shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                    )),
              ),
              onTap: () {
                setState(() {
                  color = widget.product.colours[index];
                });
              },
            ));
  }

  List<Widget> _getSizeWidget() {
    return List.generate(
        widget.product.colours?.length,
            (index) =>
            GestureDetector(
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(2),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    // 底色
                    border: Border.all(
                        color: size == widget.product.size[index]
                            ? kYellowLightColor
                            : Colors.transparent,
                        width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        widget.product.size[index],
                        style: TextStyle(fontSize: 18, color: kPrimaryColor),
                      ))),
              onTap: () {
                setState(() {
                  size = widget.product.size[index];
                });
              },
            ));
  }
}
