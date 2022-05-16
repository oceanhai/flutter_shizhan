//通用分页State封装
import 'package:flutter/material.dart';
import 'package:flutter_shizhan/model/paging_model.dart';
import 'package:flutter_shizhan/viewmodel/base_list_viewmodel.dart';
import 'package:flutter_shizhan/widget/loading_state_widget.dart';
import 'package:flutter_shizhan/widget/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// State
abstract class BaseListState<L, M extends BaseListViewModel<L, PagingModel<L>>,
        T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {

  M get viewModel; //真实获取数据的仓库

  Widget getContentChild(M model); //真实的分页控件

  bool enablePullDown = true;
  bool enablePullUp = true;

  //可以重写init 来设置修改属性值
  void init() {}

  @override
  Widget build(BuildContext context) {
    super.build(context);
    init();
    return ProviderWidget<M>(
        model: viewModel,
        onModelInit: (model) => model.refresh(),
        builder: (context, model, child) {
          return LoadingStateWidget(
            viewState: model.viewState,
            retry: model.retry,
            child: Container(
              color: Colors.white,
              child: SmartRefresher(
                controller: model.refreshController,
                onRefresh: model.refresh,
                onLoading: model.loadMore,
                //是否可以上拉加载
                enablePullUp: enablePullUp,
                //是否可以下拉刷新
                enablePullDown: enablePullDown,
                // 显示的界面
                child: getContentChild(model),
              ),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
