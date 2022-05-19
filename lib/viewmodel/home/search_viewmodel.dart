import 'package:flutter_shizhan/http/Url.dart';
import 'package:flutter_shizhan/http/http_manager.dart';
import 'package:flutter_shizhan/model/common_item.dart';
import 'package:flutter_shizhan/utils/toast_util.dart';
import 'package:flutter_shizhan/viewmodel/base_change_notifier.dart';
import 'package:flutter_shizhan/widget/loading_state_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchViewModel extends BaseChangeNotifier {
  //是否隐藏 搜索关键字
  bool hideKeyWord = false;
  bool hideEmpty = true;
  List<Item> dataList = [];
  String _nextPageUrl;
  // 热搜关键字
  List<String> keyWords = [];
  // 输入的关键字
  String query = '';
  // 搜索结果总共多少
  int total = 0;

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  /// 获取热搜关键字
  void getKeyWords() {
    HttpManager.getData(Url.keywordUrl, success: (result) {
      List responseList = result as List;
      keyWords = responseList.map((value) {
        return value.toString();
      }).toList();
      notifyListeners();
    }, fail: (e) {
      LeoToast.showError(e.toString());
    });
  }


  void loadMore({loadMore = true}) {
    String url;
    if (loadMore) {
      if (_nextPageUrl == null) {
        refreshController.loadNoData();
        return;
      }
      url = _nextPageUrl;
      getData(loadMore, url);
    } else {
      _reset();
      url = Url.searchUrl + query;
      getData(loadMore, url);
    }
  }

  // 搜索数据 loadMore false:首次加载  true：上拉加载
  void getData(bool loadMore, String url) {
    HttpManager.getData(url,
        success: (result) {
          Issue issue = Issue.fromJson(result);

          viewState = ViewState.done;
          total = issue.total;
          if (!loadMore) {
            dataList.clear();
            dataList.addAll(issue.itemList);
            hideEmpty = dataList.length > 0;
          } else {
            dataList.addAll(issue.itemList);
            hideEmpty = true;
          }
          //移除不需要的数据
          dataList.removeWhere((item) {
            //cover == null 的数据移除
            return item.data.cover == null;
          });
          _nextPageUrl = issue.nextPageUrl;
          hideKeyWord = true;

          refreshController.loadComplete();
        },
        fail: (e) {
          LeoToast.showError(e.toString());
          if (!loadMore) viewState = ViewState.error;
          refreshController.loadFailed();
        },
        complete: () => notifyListeners());
  }

  ///重新加载
  void _reset() {
    viewState = ViewState.loading;
    notifyListeners();
  }

  //加载更多
  void retry() {
    loadMore(loadMore: false);
  }
}