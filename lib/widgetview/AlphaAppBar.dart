import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
/// 控制透明度Appbar，默认透明
class AlphaAppBar extends StatefulWidget {
   /// appbar的高度
  final double height;
  /// 监听变化的距离高度
  final double alphaHeight;
  /// 背景色
  final Color themeColor;
  final ScrollController scrollController;
  final VoidCallback goBack;
  AlphaAppBar({Key key, this.height,this.alphaHeight, this.themeColor, this.scrollController, this.goBack}) : super(key: key);
  @override
  State<StatefulWidget> createState() => AlphaAppBarState();
}

class AlphaAppBarState extends State<AlphaAppBar>{
  double alpha = 0.0;
  double transparent = 1;
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      double offset = widget.scrollController.offset;
      if (offset > widget.alphaHeight){
        offset = widget.alphaHeight;
      }
      double ratio = (widget.alphaHeight - offset)/widget.alphaHeight;
      if(ratio != transparent){
        setState(() {
          alpha = 1 - ratio;
          transparent = ratio;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: widget.height + MediaQuery.of(context).padding.top,
        child: Stack(
          children: [
            Opacity(
              opacity: alpha,
              child: Container(
                  decoration: new BoxDecoration(
                    color: widget.themeColor,
                  )
              ),
            ),
            Opacity(
              opacity: alpha,
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: IconButton(icon: Image.asset("assets/images/ic_appbar_goback.png", width: widget.height, height: widget.height,fit: BoxFit.contain), onPressed: widget.goBack,),
                ),
            ),
            Opacity(
              opacity: transparent,
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: IconButton(icon: Image.asset("assets/images/ic_appbar_goback_transparent.png", width: widget.height, height: widget.height,fit: BoxFit.contain), onPressed: widget.goBack,),)
            ),
          ],
        ),
    );
  }

}