import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shizhan/app_init.dart';
import 'package:flutter_shizhan/http/http_manager.dart';
import 'package:flutter_shizhan/tab_navigation.dart';
import 'package:get/get.dart';

//实战
void main() {
  runApp(new MyApp());

  //Flutter沉浸式状态栏，Platform.isAndroid 判断是否是Android手机
  if (Platform.isAndroid) {
    // setSystemUIOverlayStyle:用来设置状态栏顶部和底部样式
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //异步UI更新
    return FutureBuilder(
        future: AppInit.init(), // 获取数据的方法
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {

          //TODO 网络请求试一试


          //打印状态
          print(snapshot.connectionState);
          var widget = snapshot.connectionState == ConnectionState.done
              // ? Container(
              //     color: Colors.blue,
              //   )
              ? TabNavigation()
              : Scaffold(
                  body: Center(
                    // 加载转圈
                    child: CircularProgressIndicator(),
                  ),
                );
          return GetMaterialAppWidget(child: widget);
        });
  }
}

class GetMaterialAppWidget extends StatefulWidget {
  final Widget child;

  GetMaterialAppWidget({Key key, this.child}) : super(key: key);

  @override
  _GetMaterialAppWidgetState createState() => _GetMaterialAppWidgetState();
}

class _GetMaterialAppWidgetState extends State<GetMaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'EyePetizer',
    //   initialRoute: '/',
    //   routes: {
    //     '/': (BuildContext context) => widget.child,
    //   },
    // );
    return GetMaterialApp(
      title: 'EyePetizer',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=>widget.child)
      ],
    );
  }
}
