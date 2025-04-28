# geolocator

flutter 定位比较常用的三方库，目前还在维护中。
他兼容android、ios、web、macos、windows平台

# 开始学习
  ## 关于Androidd定位
  
  1. android原生常用LocationManager库。
  2. 谷歌定位服务 (谷歌服务国内部分手机无法使用，因为好多厂商会关闭该功能)。
  
    ### 权限
      1. 粗略位置:
      ```xml
      <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
      ```
      
      2. 确保您的设备已安装并启用了Google Play服务。ACCESS_FINE_LOCATION权限依赖于Google Play服务提供的位置服务。
      ```xml
      <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
      ```

      3. 定位权限，Android Q 新增后台定位权限
      ```xml
      <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
      ```
    【注意 : android10以下申请定位权限1,2 如果是android10以上申请权限需要3】

    ### 出现问题
      4. Geolocator.getCurrentPosition方法一直在没有返回导致定位一直在定位中
        解决方法:
        ```dart
          LocationSettings? locationSettings;
          if (kIsWeb) {
            locationSettings = WebSettings(
              timeLimit: const Duration(seconds: 5),
              maximumAge: const Duration(days: 7),
            );
          } else if (Platform.isAndroid) {
            locationSettings = AndroidSettings(
              forceLocationManager: true, // 这里设置通过android原生常用LocationManager库进行使用
              timeLimit: const Duration(seconds: 5),
            );
          } else {
            locationSettings = LocationSettings(
              timeLimit: const Duration(seconds: 5),
            );
          }
          position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings,
        );
        ```

      5. 永久拒绝权限申请
        解决方案:
        ```dart
        Geolocator.openAppSettings();
        ```
        使用openAppSetting打开手机权限设置界面手动添加权限

  ## 关于web定位问题
    1. web不支持接口:
    ```dart
      getLastKnownPosition({ bool forceAndroidLocationManager = true });
      openAppSettings();
      openLocationSettings();
      getServiceStatusStream();
    ```
  ## 关于LocationSettings设置
    根据项目的不同需要设置不同的LocationSetting以配置不同的设备。尽量使用对应设备的 LocationSettings 以防止设备在获取位置信息时出现问题。
    实例:
    ```dart
      LocationSettings? locationSettings;
      if (kIsWeb) {
        locationSettings = WebSettings(
          distanceFilter: 100,
          timeLimit: const Duration(seconds: 5),
          maximumAge: const Duration(days: 7),
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS) {
        locationSettings = AppleSettings(
          accuracy: LocationAccuracy.high,
          activityType: ActivityType.fitness, // 活动类型
          distanceFilter: 100,
          pauseLocationUpdatesAutomatically: true,
          // 程序在后台启动时设置为true.
          showBackgroundLocationIndicator: false,
        );
      } else if (Platform.isAndroid) {
        locationSettings = AndroidSettings(
          forceLocationManager: true,
          distanceFilter: 100,
          timeLimit: const Duration(seconds: 5),
          // 程序程序转到后台时保持活动使用
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText: "应用程序将继续接收您的位置信息",
            notificationTitle: "后台运行",
            enableWakeLock: true,
          ),
        );
      } else {
        locationSettings = const LocationSettings(
          distanceFilter: 100,
          timeLimit: Duration(seconds: 5),
        );
      }
    ```
  ## 距离计算
  ```dart
  import 'package:geolocator/geolocator.dart';
  double distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
  ```
  Geolocator.distanceBetween 计算两个坐标点之间的距离,返回对象是米
  

# 产考文档[online documentation]：
1. https://pub.dev/packages/geolocator  geolocator官方文档
2. https://blog.51cto.com/u_16099324/9449724
3. https://blog.csdn.net/llssdshiyi/article/details/135523326
