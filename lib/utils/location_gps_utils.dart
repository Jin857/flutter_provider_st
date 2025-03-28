import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationGPSUtils {
  /// 获取经纬度
  /// 只有真机模式下才会执行
  static Future<Position?> getLatitudeLongitude() async {
    if (await isOpenLocation()) {
      try {
        Position? position = await getPosition();
        return position;
      } catch (e) {
        debugPrint('无法获取位置:$e');
      }
    } else {
      debugPrint("获取经纬度前未获取权限");
    }
    return null;
  }

  /// 获取当前 Position
  static Future<Position?> getPosition() async {
    Position? position;
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
    try {
      position = await Geolocator.getLastKnownPosition(
        forceAndroidLocationManager: true,
      );
      position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
    } catch (e) {
      debugPrint("get loacation error:$e");
    }
    debugPrint(
      "latitude:${position?.latitude} longitude:${position?.longitude}",
    );
    return position;
  }

  /// 当前需要定位，检测当前是否开启定位给予提示
  static Future<bool> isOpenLocation() async {
    bool isGranted = false;
    var locationPermission = await Geolocator.checkPermission();
    debugPrint('定位权限 - locationPermission - $locationPermission');
    switch (locationPermission) {
      case LocationPermission.denied: //  访问设备位置的权限被拒绝，应用程序应尝试
        var permission = await Geolocator.requestPermission();
        debugPrint('定位权限 - permission - $permission');
        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          isGranted = true;
        } else if (permission == LocationPermission.deniedForever) {
          // DefaultDialog.dialog(
          //   context,
          //   title: "申请访问定位权限",
          //   cancel: "去设置",
          //   content: const Text(
          //       "三商共富需要使用您的当前位置，用于在您提现时缴纳当地税款、展示您所在地区的纳税记录、线下实体福利等功能"),
          //   confirm: "取消",
          //   onConfirm: () {},
          //   onCancel: () async {
          //     openAppSettings();
          //   },
          // );
        }
        break;
      case LocationPermission.deniedForever: // 访问设备位置的权限被永久拒绝
        // DefaultDialog.dialog(
        //   context,
        //   title: "申请访问定位权限",
        //   cancel: "去设置",
        //   content:
        //       const Text("三商共富需要使用您的当前位置，用于在您提现时缴纳当地税款、展示您所在地区的纳税记录、线下实体福利等功能"),
        //   confirm: "取消",
        //   onConfirm: () {},
        //   onCancel: () async {
        //     openAppSettings();
        //   },
        // );
        break;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        isGranted = true;
        break;
      default:
        break;
    }

    return isGranted;
  }

  /// 打开App系统设置界面进行手动设置
  static void openAppSettings() async {
    if (Platform.isAndroid) {
      await Geolocator.openAppSettings();
    } else if (Platform.isIOS) {
      await Geolocator.openAppSettings();
    } else {
      throw '不支持该平台';
    }
  }
}
