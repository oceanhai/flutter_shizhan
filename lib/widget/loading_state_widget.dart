import 'package:flutter/material.dart';
import 'package:flutter_shizhan/config/color.dart';
import 'package:flutter_shizhan/config/string.dart';

enum ViewState { loading, done, error }

class LoadingStateWidget extends StatelessWidget {
  final ViewState viewState;
  final VoidCallback retry;
  final Widget child;

  /// viewState   状态
  /// retry       重新加载
  /// child       真正布局
  LoadingStateWidget(
      {Key key, this.viewState = ViewState.loading, this.retry, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (viewState == ViewState.loading) {
      return _loadView;
    } else if (viewState == ViewState.error) {
      return _errorView;
    } else {
      return child;
    }
  }

  Widget get _errorView {
    return Center(
      // 类似LinearLayout
      child: Column(
        //横轴 居中
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/ic_error.png',
            width: 100,
            height: 100,
          ),
          Padding(
            //间距8 距离上
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              LeoString.net_request_fail,
              style: TextStyle(color: LeoColor.hitTextColor, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            //外边框
            child: OutlinedButton(
              onPressed: retry,
              child: Text(
                LeoString.reload_again,
                style: TextStyle(color: Colors.black87),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.black12)),
            ),
          )
        ],
      ),
    );
  }

  Widget get _loadView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
