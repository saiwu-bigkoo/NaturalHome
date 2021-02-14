import 'package:flutter/widgets.dart';
/// 设备信息管理
class DeviceManager {
  /// 单例对象
  // 无论是new还是_getInstance都是返回同一个实例
  factory DeviceManager() =>getInstance();
  static DeviceManager get instance => getInstance();
  static DeviceManager _instance;
  DeviceManager._internal();

  static DeviceManager getInstance() {
    if (_instance == null) {
      _instance = new DeviceManager._internal();
    }
    return _instance;
  }

  double screenWidth;
  double screenHeight;
  double statusBarHeight;

  init(BuildContext context){
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    statusBarHeight = MediaQuery.of(context).padding.top;
  }

  double getScreenWidth(){
    return screenWidth;
  }
}