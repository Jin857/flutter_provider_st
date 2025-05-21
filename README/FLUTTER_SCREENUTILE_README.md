# flutter_screenutile 学习

flutter_screenutile 适配方案可以理解成将页面根据显示屏幕大小进行网格化。

打开源码可以看到 designSize: Size(360, 690),也就是将屏幕进行分割 宽度分成360份,高度分成690份。而使用 10.w,10.h 都是在使用高度宽度网格中的 10 份，通过这种方式可以很好的进行屏幕适配。


同时建议：
  在使用 screenutile 的同时使用 FittedBox, FittedBox 是对固定宽高盒子内部组件的约束组件。具体可以在官网上查看。



