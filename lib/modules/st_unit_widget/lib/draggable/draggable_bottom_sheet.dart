import 'package:flutter/material.dart';

/// 可拖拽悬浮面板
class DraggableBottomSheet extends StatefulWidget {
  /// 悬浮界面 - 最小高度比例
  final double minChildSize;

  /// 悬浮界面 - 最大高度
  final double maxChildSize;

  /// 悬浮界面 - 初始高度比例
  final double initialChildSize;

  /// 是否显示悬浮界面
  final bool show;

  /// 主界面内容
  final Widget mainWidget;

  /// 悬浮界面
  final Widget Function(
    BuildContext context,
    ScrollController scrollController,
    double currentSize,
  )
  builder;

  const DraggableBottomSheet({
    super.key,
    required this.show,
    required this.mainWidget,
    required this.minChildSize,
    required this.maxChildSize,
    required this.initialChildSize,
    required this.builder,
  });

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  late DraggableScrollableController _sheetController;

  /// 最大高度 - 初始化确定并赋值
  late final double maxChildSize;

  /// 最小高度 - 初始化确定并赋值
  late final double minChildSize;

  /// 初始化高度
  late double initialChildSize;

  /// 当前位置
  late double _currentSize;

  @override
  void initState() {
    super.initState();
    maxChildSize = widget.maxChildSize;
    minChildSize = widget.minChildSize;
    initialChildSize = widget.initialChildSize;
    _currentSize = widget.initialChildSize;
    _sheetController = DraggableScrollableController();
    // 监听面板大小变化
    _sheetController.addListener(() {
      setState(() {
        _currentSize = _sheetController.size;
      });
    });
  }

  @override
  void didUpdateWidget(covariant DraggableBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialChildSize != initialChildSize) {
      if (_currentSize == initialChildSize) {
        _currentSize = widget.initialChildSize;
      }
      initialChildSize = widget.initialChildSize;
      if (widget.initialChildSize != oldWidget.initialChildSize &&
          _currentSize == initialChildSize) {
        _sheetController.animateTo(
          widget.initialChildSize,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {}
    }
  }

  @override
  void dispose() {
    _sheetController.removeListener(() {});
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 主界面内容
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: widget.mainWidget,
        ),
        if (widget.show && _currentSize != minChildSize)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withValues(alpha: 0.65),
          ),
        if (widget.show)
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: initialChildSize, // 初始高度占比（0-1）
            minChildSize: minChildSize, // 最小高度占比
            maxChildSize: maxChildSize, // 最大高度占比
            snap: true, // 是否启用滑动后自动吸附到最近的尺寸
            shouldCloseOnMinExtent: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return widget.builder(context, scrollController, _currentSize);
            },
          ),
      ],
    );
  }
}
