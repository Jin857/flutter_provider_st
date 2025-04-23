# canvas 学习

Canvas是一个强大的2D绘图工具。可以用来绘制各种形状、线条、文本和图像等。

# 通常使用以下方法调用原生层（C++）的绘图操作:
  ```dart
  factory Canvas(PictureRecorder recorder, [ Rect? cullRect ]) = _NativeCanvas;
  ```

# 可以通过以下方法保存和恢复当前绘制:
  ```dart
  void save();
  void saveLayer(Rect? bounds, Paint paint);

  void restore();
  void restoreToCount(int count);

  /// 保存数量
  int getSaveCount();
  ``` 

# 绘图方式:
1. 平移
  ```dart
  void translate(double dx, double dy);
  ```
2. 缩放
  ```dart
  void scale(double sx, [double? sy]);
  ```
3. 旋转
  ```dart
  void rotate(double radians);
  ```
4. 倾斜
  ```dart
  void skew(double sx, double sy);
  ```
5. 变换4x4矩阵
  ```dart
  void transform(Float64List matrix4);
  ```

# 绘制渲染
  drawLine	画线
  drawPoint	画点
  drawPath	画路径
  drawImage	画图像
  drawRect	画矩形
  drawCircle	画圆
  drawOval	画椭圆
  drawArc	画圆弧






