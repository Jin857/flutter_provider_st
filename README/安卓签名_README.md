# 应用签名以将其发布到 Google Play

  如果你已经有一个密钥库了，可以直接跳到下一步，如果还没有，需要参考下面的方式创建一个：

# 创建一个用于上传的密钥库
  ## 创建方法一： 参考文档：在 Android Studio 上为你的应用签名。([https://developer.android.google.cn/studio/publish/app-signing?hl=zh-cn#generate-key])

  ## 创建方法一： 在命令行窗口运行如下的命令
    keytool -genkeypair -v -keystore <keystore_file> -alias <alias_name> -keyalg <algorithm> -keysize <size> -validity <days>
    
    -genkeypair: 指定生成密钥对。
    -v: 显示详细输出。
    -keystore <keystore_file>: 指定keystore文件的名称和位置。如果你不指定路径，keystore文件将被创建在当前目录下。例如：my-key.jks。
    -alias <alias_name>: 为你的密钥指定一个别名。这个别名是在使用keystore时用来引用特定密钥的。例如：my-key-alias。
    -keyalg <algorithm>: 指定密钥算法。对于Android，推荐使用RSA。例如：RSA。
    -keysize <size>: 指定密钥长度，通常为2048位。例如：2048。
    -validity <days>: 指定密钥的有效期（以天为单位）。例如：10000（大约27.4年），建议设置长点（36500 100年），避免证书失效。

    需要输入的内容:
    First and last Name：您的名字和姓氏是什么
    Orgenizational Unit：组织单位名称
    Orgenization：机构（组织）名称
    City or Locatity：省
    State or province ：市
    Country Code(XX)：国家代码

    Mac: keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
        -keysize 2048 -validity 10000 -alias upload

    Win: keytool -genkey -v -keystore $env:USERPROFILE\upload-keystore.jks `
        -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 `
        -alias upload

    keytool: 可能不在我们的系统路径中。它是 Java 的一部分，在安装 Android Studio 的时候会被一起安装。运行 flutter doctor -v，'Java binary at:' 之后打印出来的就是它的路径，然后用 java 来替换以上命令中的 keytool，并加上 keytool 的完整路径即可。如果文件路径包含空格，类似 Program Files 这样的，请使用平台允许的命名规则。例如，在 Mac/Linux 上使用 Program\ Files，而在 Windows 上可以使用 "Program Files"。

# 配置签名（<project>/android/app/build.gradle）
  
  1. 在 android 属性块之前定义并加载 keystore properties 文件。
  
  2. 设置 keystoreProperties 对象，来加载 key.properties 文件。
   
  ```gradle   
    def keystoreProperties = new Properties()
    def keystorePropertiesFile = rootProject.file('key.properties')
    if (keystorePropertiesFile.exists()) {
      keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
    }
   ```
  
  1. 在 android 属性块内的 buildTypes 属性块前面添加签名配置。
  ```gradle
   signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
        debug {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
  ```
# android 打包
## 上传AppStore
  flutter build appbundle 
  添加混淆
  flutter build appbundle --obfuscate  --split-debug-info=./symbols/
## 本地下载apk
  flutter build apk
  添加混淆
  flutter build appbundle --obfuscate  --split-debug-info=./symbols/
  添加不同版本
  flutter build appbundle  --split-per-abi --obfuscate  --split-debug-info=./symbols/
  如果移除  --split-per-abi 将会生成一个包含 所有 目标 ABI 的 fat APK 文件。这种 APK 文件将会在比单独构建的 APK 文件尺寸要大，会导致用户下载一些不适用于其设备架构的二进制文件。







