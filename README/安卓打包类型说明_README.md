# 安卓打包类型说明

## Android客户端的安装包文件，有以下几个版本可以选择：
mobile-release.apk（通用版本，体积最大）

mobile-universal-release.apk
mobile-arm64-v8a-release.apk（第8代64位处理器）
mobile-armeabi-v7a-release.apk
mobile-x86-release.apk
mobile-x86_64-release.apk

## 各个版本之间有什么区别？

### arm64-v8a
  第8代、64位ARM处理器。目前，国内Android应用生态正在向64位架构过渡。同时，移动芯片平台也将逐步弱化对32位应用的支持。

### armeabiv-v7a
  第7代及以上的 ARM 处理器，是目前主流版本，大部分Android设备都使用它。

### armeabi
  第5代、第6代的ARM处理器，早期的手机用的比较多，缺乏对浮点数计算的硬件支持，在须要大量计算时有性能瓶颈。

### x86 / x86_64
x86 架构的手机都会包含由 Intel 提供的称为 Houdini 的指令集动态转码工具，实现对arm .so 的兼容。考虑 x86不到1% 的市场占有率，x86 相关的两个 .so 也是可以忽略的。

### mips/mips64
极少用于手机可忽略。


## 应该下载哪个版本的安装包？
  普通手机用户，建议下载arm64-v8a（第8代、64位ARM处理器）版本，能够发挥手机最佳性能（只要本型号手机支持8G运存或8G以上就是64位处理器)。如果是很老的手机，也有可能不是64位处理器，那么就选择armeabi-v7a，几乎通用所有手机，而且也兼容64位处理器。
  以前面图片的安卓应用为例，第一个是 mobile-release.apk ，没有标明处理器版本，通常是通用版本，有的应用会写上-universal。这个版本所有安卓手机都兼容，但是安装包文件大小是其他版本的几倍。所以没必要选择，忽略该版本。接着是arm64-v8a和armeabi-v7a了，通常情况下arm64-v8a可以覆盖armeabi-v7a安装，而后者不能覆盖前者，需要卸载arm64-v8a才能安装armeabi-v7a。最后面两个版本几乎没有手机在用了，也忽略掉。






