import 'dart:convert';

import 'package:flutter_shizhan/http/Url.dart';
import 'package:flutter_shizhan/http/http_manager.dart';
import 'package:flutter_shizhan/model/discovery/recommend_model.dart';
import 'package:flutter_shizhan/utils/toast_util.dart';
import 'package:loading_more_list/loading_more_list.dart';


class RecommendLoading extends LoadingMoreBase<RecommendItem> {
  String nextPageUrl;
  bool _hasMore = true;
  bool forceRefresh = false;
  Utf8Decoder utf8decoder = Utf8Decoder();

  @override
  bool get hasMore => _hasMore || forceRefresh;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    forceRefresh = !notifyStateChanged;
    // 内部加载数据
    final bool result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    String url = '';
    if (isloadMoreAction) {
      url = nextPageUrl;
    } else {
      url = Url.communityUrl;
    }

    return HttpManager.requestData(url, headers: Url.httpHeader).then((result) {
      RecommendModel model = RecommendModel.fromJson(result);
      //去除特定type类型的数据
      model.itemList.removeWhere((item) {
        return item.type == 'horizontalScrollCard';
      });
      if (!isloadMoreAction) {
        clear();
      }
      addAll(model.itemList);
      nextPageUrl = model.nextPageUrl;
      _hasMore = nextPageUrl != null;
      return true;
      // return Future.value(true);
    }).catchError((e) {
      LeoToast.showError(e.toString());
      return false;
      // return Future.value(false);
    });
  }
}