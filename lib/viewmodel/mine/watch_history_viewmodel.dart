import 'dart:convert';

import 'package:flutter_shizhan/model/common_item.dart';
import 'package:flutter_shizhan/utils/history_repository.dart';
import 'package:flutter_shizhan/viewmodel/base_change_notifier.dart';


class WatchHistoryViewModel extends BaseChangeNotifier {
  List<Data> itemList = [];
  List<String> watchList = [];

  void loadData() {
    watchList = HistoryRepository.loadHistoryData();
    if (watchList != null) {
      var list = watchList.map((value) {
        return Data.fromJson(json.decode(value));
      }).toList();
      itemList = list;
      notifyListeners();
    }
  }

  void remove(int index) {
    watchList.removeAt(index);
    HistoryRepository.saveHistoryData(watchList);
    loadData();
  }
}