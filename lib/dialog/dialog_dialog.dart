// 封装一个 dialog
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultDialog {
  /// 普通弹窗
  static void dialog(
    BuildContext context, {
    String title = "温馨提示",
    Widget? content,
    String confirm = "确定",
    String cancel = "取消",
    Function? onConfirm,
    Function? onCancel,
    Color? backgroundColor,
    Widget? confirmButton,
    Widget? cancelButton,
    TextStyle? titleStyle,
  }) {
    List<Widget> list = [];
    if (confirmButton != null) {
      list.add(confirmButton);
    }
    if (cancelButton != null) {
      list.add(cancelButton);
    }

    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CupertinoActionSheet(
            title: Stack(alignment: Alignment.center, children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: titleStyle ??
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.close),
                ),
              )
            ]),
            message: content,
            actions: [
              ...list,
              if (onConfirm != null)
                Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(30.0), //3像素圆角
                  ),
                  child: TextButton(
                    style: const ButtonStyle(),
                    child: Text(
                      confirm,
                      style: const TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                  ),
                ),
              if (onCancel != null)
                cancelButton ??
                    Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30.0), //3像素圆角
                      ),
                      child: TextButton(
                        style: const ButtonStyle(),
                        child: Text(
                          cancel,
                          style: const TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          onCancel();
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
