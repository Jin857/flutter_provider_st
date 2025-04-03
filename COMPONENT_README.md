# flutter component 学习
本章节主要是学习flutter组件在实际开发中的应用以及封装。

# Overlay 

可以直接创建一个 Overlay 对象来使用，但是更一般的，都是使用 WidgetsApp 或者 MaterialApp 里面的 Navigator 创建了 Overlay，Navigator 使用这个 overlay 来管理路由显示效果（我们可以通过这个 overlay 来实现全局弹窗）。

Overlay：可以独立显示的 Widget。
OverlayEntry : 用来管理 Overlay 显示层级。

通常使用在 弹窗、小提示、悬浮等业务逻辑。需要注意控制其生命周期,防止内存溢出。

## 使用方式:
  1. 创建OverlayEntry对象
  ```dart
  Overlay entry=new OverlayEntry(
    builder:(){
    //自己的 widget
    });
  ```

  2. 将 OverlayEntry 插入到 Overlay 中展示
  ```dart
   Overlay.of(context).insert(overlayEntry);
  ```

  3. 将 OverlayEntry 移除
  ```dart
   entry.remove();
  ```

  ## 实际使用
    1. 封装自定义悬浮组件（snackbar）
      查考Getx的Get.showSnackbar()进行封装，自定一内部weidgt,可产考本地 lib/view/snackbar 目录下组件进行处理。可同 animation 动画共同使用,实现全局飞动画等业务处理。
    2. Toast 提示
      实现逻辑产考 lib/view/component/my_toast.dart





