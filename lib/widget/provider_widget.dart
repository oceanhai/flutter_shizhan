import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model; //维护数据的
  final Widget child;

  final Function(T) onModelInit; //请求网络数据
  final Widget Function(BuildContext context, T model, Widget child) builder;

  ProviderWidget(
      {Key key,
      @required this.model,
      @required this.builder,
      this.child,
      this.onModelInit})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProvideWidgetState<T>();
}

class _ProvideWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {

  T model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    if(widget.onModelInit != null && model != null){
      widget.onModelInit(model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }

}
