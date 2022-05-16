
import 'package:flutter_shizhan/http/Url.dart';
import 'package:flutter_shizhan/model/discovery/topic_model.dart';
import 'package:flutter_shizhan/viewmodel/base_list_viewmodel.dart';

class TopicPageViewModel extends BaseListViewModel<TopicItemModel,TopicModel>{

  @override
  String getUrl() {
    return Url.topicsUrl;
  }

  @override
  TopicModel getModel(Map<String, dynamic> json) {
    return TopicModel.fromJson(json);
  }
}