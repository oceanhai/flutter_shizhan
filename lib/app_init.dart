import 'package:flutter_shizhan/http/Url.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
// import 'package:leo_eyepetizer/http/Url.dart';

class AppInit {

  //不让外部掉用我的构造方法
  AppInit._();

  static Future<void> init() async {
    //初始化 baseUrl
    Url.baseUrl = 'http://baobab.kaiyanapp.com/api/';

    Future.delayed(Duration(milliseconds: 2000), () {
      FlutterSplashScreen.hide();
    });
  }
}
