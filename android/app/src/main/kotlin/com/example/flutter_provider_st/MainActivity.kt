package com.example.flutter_provider_st

import android.os.Build
import android.os.Bundle
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity(){
    override fun onCreate(savedInstanceState: Bundle?) {
        // 1. 设置窗口装饰不占用系统窗口（让Flutter视图与窗口垂直对齐）
        // WindowCompat.setDecorFitsSystemWindows(getWindow(), false)

        // 2. 针对Android 12 (API 31/S)及以上版本的特别处理
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // 禁用Android原生启动屏的淡出动画，避免在Flutter绘制相似帧之前出现闪烁
            splashScreen.setOnExitAnimationListener { splashScreenView ->
                splashScreenView.remove()
            }
        }

        // 3. 调用父类的onCreate方法
        super.onCreate(savedInstanceState)
    }
}
