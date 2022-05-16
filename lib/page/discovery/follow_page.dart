import 'package:flutter/material.dart';
import 'package:flutter_shizhan/model/common_item.dart';
import 'package:flutter_shizhan/state/base_list_state.dart';
import 'package:flutter_shizhan/viewmodel/discovery/follow_viewmodel.dart';
import 'package:flutter_shizhan/widget/discovery/follow_item_widget.dart';

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState
    extends BaseListState<Item, FollowViewModel, FollowPage> {
  @override
  Widget getContentChild(FollowViewModel model) => ListView.separated(
    separatorBuilder: (context, index) => Divider(height: 0.5),
    itemCount: model.itemList.length,
    itemBuilder: (context, index) {
      return FollowItemWidget(item: model.itemList[index]);
    },
  );

  @override
  FollowViewModel get viewModel => FollowViewModel();
}