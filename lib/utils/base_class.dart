import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../main.dart';
import 'const.dart';

abstract class BaseFullState<T extends StatefulWidget> extends State<T>
    with LifecycleBack {


  // var api = RepositoryProvider.of<RemoteDataSource>(context);
  BuildContext? con;


  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  double? _height;

  double get height {
    if (_height == null) {
      setWidthAndHeight();
    }
    return _height ?? 0;
  }

  double get width {
    if (_height == null) {
      setWidthAndHeight();
    }
    return _width ?? 0;
  }

  set height(double? value) {
    _height = value;
  }

  double? _width;

  // @override
  // Widget build(BuildContext context) {
  //
  //   con = context;
  //
  //
  //
  //   return WillPopScope(
  //     onWillPop: backPressed, child: Container(),
  //   );
  // }
  void baseMethod() {
    // Parent method
  }

  setWidthAndHeight() {
    _width = MediaQuery.of(context).size.width;

    _height = MediaQuery.of(context).size.height;

    Const.width = _width ?? 0;
    Const.height = _height ?? 0;
  }

  backPressed() {
    Navigator.pop(con!);
  }

  backGroundImage(imageUrl) {
    return Image.asset(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }


}

abstract class BaseStateLess extends StatelessWidget   with LifecycleBack {

  BaseStateLess({Key? key}) : super(key: key);
   double?  _height;

   late BuildContext context;

   double? _width;


  Widget body(BuildContext context);


  @override
  Widget build(BuildContext context) {
    this.context = context;

    return body(context);
  }


  double get height {
    if (_height == null) {
      setWidthAndHeight();
    }
    return _height ?? 0;
  }

  double get width {
    if (_width == null) {
      setWidthAndHeight();
    }
    return _width ?? 0;
  }

  set height(double? value) {
    _height = value;
  }

  fontS(width, i) {
    return ((width / 400) * i);
  }
  sizeView(width, i) {
    return ((width / 400) * i);
  }


  void baseMethod() {
    // Parent method
  }

  setWidthAndHeight() {


    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
  }

  void showToast(message) {
    final snackBar = SnackBar(
        content: Text(
          message,
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class LifecycleBack {
  backed() {}

  pushed() {}
}
