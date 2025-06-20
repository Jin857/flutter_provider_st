# 代码混淆
  
  混淆分为原生端代码混淆和Dart代码混淆两部分

# 关于 flutter 代码混淆

## 启用混淆
  在打包的时候加入一下代码
    --obfuscate --split-debug-info=./symbols/
  其中:
    --obfuscate  : 开启 Dart 代码混淆（会混淆类名、方法名等）
    --split-debug-info=./symbols/  存储生成的符号表，避免混淆后无法解读堆栈信息，symbols 为生成的符号表目录

    eg:
    android release 混淆
    flutter build apk --release --obfuscate --split-debug-info=./symbols/
    Ios 混淆
    flutter build ios --obfuscate --split-debug-info=./symbols/
  
    对应的symbols中会生成符号表文件:
    symbols/
      ├── app.android-arm.symbols
      ├── app.android-arm64.symbols
      ├── app.android-x64.symbols
    这些文件用于解混淆崩溃日志。

## Flutter Dart 代码解混淆
  使用 flutter symbolize 解混淆
  flutter symbolize -i [stack_trace_file] -d [symbols_file] > [out_file]
  
  [stack_trace_file]	将需要解混淆的 Dart 代码拷贝到文件中，例如 crash.txt
  [symbols_file]	指定 Flutter 生成的符号表文件，注意要制定对应架构的解码文件
  [out_file]	解码后的堆栈输出到 out_file 文件中
  
  eg:
  flutter symbolize -i /Users/xxx/crash.txt -d /Users/xxx/app.android-arm64.symbols > out.txt


# Android混淆
  proguardFiles getDefaultProguardFile('proguard-android-optimize.txt')
  proguardFiles 'proguard-rules.pro'
  配置proguard-rules.pro进行混淆
  
        




