
import 'package:flutter_shizhan/http/Url.dart';
import 'package:flutter_shizhan/http/http_manager.dart';
import 'package:flutter_shizhan/model/common_item.dart';
import 'package:flutter_shizhan/model/issue_model.dart';
import 'package:flutter_shizhan/utils/toast_util.dart';
import 'package:flutter_shizhan/viewmodel/base_change_notifier.dart';
import 'package:flutter_shizhan/widget/loading_state_widget.dart';

class HomePageViewModel extends BaseChangeNotifier {
  List<Item> bannerList = [];

  // 刷新数据
  void refresh() {
    HttpManager.getData(
      Url.feedUrl,
      success: (json) {
        IssueEntity model = IssueEntity.fromJson(json);
        bannerList = model.itemList;
        // 移除类型为 'banner2'
        bannerList.removeWhere((element) => element.type == 'banner2');
        viewState = ViewState.done;
      },
      fail: (e) {
        LeoToast.showError(e.toString());
      },
      complete: () => notifyListeners(),
    );
  }

  //错误重试
  retry() {
    viewState = ViewState.loading;
    //TODO 这个notifyListeners没必要吧
    notifyListeners();
    refresh();
  }
}
