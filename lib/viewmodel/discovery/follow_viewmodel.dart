
import 'package:flutter_shizhan/http/Url.dart';
import 'package:flutter_shizhan/model/common_item.dart';
import 'package:flutter_shizhan/viewmodel/base_list_viewmodel.dart';

class FollowViewModel extends BaseListViewModel<Item, Issue> {
  @override
  String getUrl() {
    return Url.followUrl;
  }

  @override
  Issue getModel(Map<String, dynamic> json) {
    return Issue.fromJson(json);
  }
}