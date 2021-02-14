import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naturalhome/constants/ColorConstants.dart';
import 'package:naturalhome/constants/ValueConstants.dart';

enum TwoSidesModel {
  light,
  dark
}
/// 两面Appbar，支持 light and dark 模式, 如果goBack是空，则不显示返回图标
class TwoSidesAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double contentHeight; //高度
  final Widget rightWidget;
  final String title;
  final TwoSidesModel model;
  final VoidCallback goBack;

  TwoSidesAppBar({Key key,
    this.title,
    this.contentHeight = appbarHeight,
    this.rightWidget, this.model = TwoSidesModel.light, this.goBack
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwoSidesAppBarState();
  }

  @override
  Size get preferredSize => new Size.fromHeight(contentHeight);
}

class TwoSidesAppBarState extends State<TwoSidesAppBar> {
  Color backgroundColor;
  Color titleColor;
  String leftImage;
  @override
  void initState() {
    super.initState();
    switch (widget.model){
      case TwoSidesModel.dark:
        backgroundColor = kPrimaryColor;
        titleColor = Colors.white;
        leftImage = "assets/images/ic_appbar_goback.png";
        break;
      default:
        backgroundColor = Colors.white;
        titleColor = kPrimaryColor;
        leftImage = "assets/images/ic_appbar_goback_light.png";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: backgroundColor,
      child: new SafeArea(
        top: true,
        child: new Container(
            decoration: new UnderlineTabIndicator(
              borderSide: BorderSide(width: 0.5, color: kDividerColor),
            ),
            height: widget.contentHeight,
            child: new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  child: widget.goBack == null ? Container() : IconButton(icon:  Image.asset(leftImage, fit: BoxFit.contain, width: widget.contentHeight,
                    height: widget.contentHeight,), onPressed: widget.goBack),
                ),
                new Container(
                  child: new Text(widget.title,
                      style: new TextStyle(
                          fontSize: 18, color:titleColor)),
                ),
                Positioned(
                  right: 0,
                  child: new Container(
                    height: widget.contentHeight,
                    child: widget.rightWidget,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
