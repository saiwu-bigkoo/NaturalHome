import 'package:flutter_kata/kata.dart';

abstract class CartPageViewable extends BaseListViewable{
  onCountChange();
  onPaySuccess(dynamic data, String msg);
  onPayFailed(int code, String msg, [dynamic data]);
}